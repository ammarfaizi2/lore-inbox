Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267612AbTBFUOQ>; Thu, 6 Feb 2003 15:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267617AbTBFUOQ>; Thu, 6 Feb 2003 15:14:16 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:56991 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267612AbTBFUOO>;
	Thu, 6 Feb 2003 15:14:14 -0500
Subject: [ANNOUNCE] LTP-20030206
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OF9C3B195A.22785F3A-ON85256CC5.006F874E-86256CC5.00705061@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Thu, 6 Feb 2003 14:23:03 -0600
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 02/06/2003 03:23:41 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project test suite LTP-20030206.tgz has been released. Visit
our website (http://ltp.sourceforge.net) to download the latest version of
the testsuite that contains
950+ tests for the Linux OS.  The site also contains other information such
as: test results, a Linux test tools matrix, technical papers and HowTos on
Linux testing, and a code coverage analysis tool.  There is also a list of
test cases that are expected to fail, located at
(http://ltp.sourceforge.net/expected-errors.php)

The highlights of this release are:

 - New options added to 'pan'.
   - quiet mode to reduce output ( -q )
   - pretty mode to format logfile output ( -p ).
 - New options added and changes made to "runalltests.sh".
   - network tests can be run from runalltests (-N).
   - Optional cpu (-c), memory (-m), i/o (-i), and network (-n)
     load generation.
   - default result log directory is now /results.
 - New tests added that cover:
   - hyperthreading
   - stressing mmap()
   - libmm
   - commands such as: cpio, ln, and cp
 - Inclusion of all submitted and accepted patches/fixes through 02/05/03.

We encourage the community to post results, patches, or new tests on our
mailing list, and to use the CVS bug tracking facility to report problems
that you might encounter. More details available at our web-site.


ChangeLog
---------
- Applied cross-compiler patch for top-level      ( V.R. Sundar )
  Makefile.
- Added additional runtime options to the         ( Manoj Iyer &
  "runalltests.sh" script.                          Robbie Williamson )
- Corrected runalltests.sh -l option to require   ( Paul Larson )
  an absolute path.
- Added additional runtime and output options     ( Manoj Iyer )
  to `pan`.
- Added hyperthreading tests.                     ( Sonic Zhang )
- Added ftruncate04 tests.                  ( Robbie Williamson )
- Changed top-level Makefiles to not require      ( Robbie Williamson )
  updating everytime a directory is added.
- Applied s390/64-bit enablement patch.           ( Susanne Wintenberger )
- Applied 64bit patch to stress_cd.         ( Jay Turner )
- Applied optimization patches (-O2).             ( Mikael Starvik &
                                        V.R. Sundar )
- Added mmapstress testsuite.               ( Ananda Venkataraman )
- Added new testcases to test shared library      ( Manoj Iyer )
  libmm.
- Applied patch to mem01 to allow test to run     ( Jacky Malcles )
  on 2.4 and 2.5 kernels.
- Changed sched_stress testsuite from using       ( Robbie Williamson )
  the bootfile, to generating its' own
  datafile.
- Corrected cleanup section of abort01 test.      ( Robbie Williamson )
- Added code to acct(2) tests to check for        ( Robbie Williamson )
  BSD accounting before execution.
- Corrected description of flock03.               ( Robbie Williamson )
- Added code to handle formatting issues with     ( Robbie Williamson )
  gethostid01 test.
- Applied patch to ioperm(2) & iopl(2) tests to   ( V.R. Sundar )
  check for IA32 architecture before executing.
- Added code to msgctl08 and msgctl09 to ensure   ( Robbie Williamson )
  correct and better execution with respect to
  message queue limits.
- Fix recvfrom01 & recvmsg01 to test for the      ( Paul Larson )
  correct expected errors and their associated
  returns.
- Applied patch to sendfile02 to allow the test   ( V.R. Sundar )
  to function correctly and keep track of its'
  children.
- Applied patch to setrlimit01 to test for        ( V.R. Sundar )
  SIGXFSZ
- Applied patch to swapoff02 and swapon02 to      ( Susanne Wintenberger )
  allow the test to use /dev/tty, instead of
  /dev/mouse.
- Applied buffer overflow patch to swapon02.      ( Chris Dearman )
- Added code to fptest03 to check endianess       ( Robbie Williamson )
  before defining unions.
- Added testsuite for multi-threaded core dump    ( Guo Min )
  kernel patch.
- Added netpipe as a network traffic generator    ( Robbie Williamson )
  tool.
- Added `cpio` command test.                ( Manoj Iyer )
- Added `ln` command test.                  ( Manoj Iyer )
- Added `cp` command test.                  ( Manoj Iyer )
- Added `mkdir` command test.               ( Manoj Iyer )
- Added `mv` command test.                  ( Manoj Iyer )


