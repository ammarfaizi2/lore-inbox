Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318116AbSIJVD6>; Tue, 10 Sep 2002 17:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318131AbSIJVD5>; Tue, 10 Sep 2002 17:03:57 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:7322 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318116AbSIJVDz>;
	Tue, 10 Sep 2002 17:03:55 -0400
Subject: [ANNOUNCE] ltp-20020910 released 
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFF5DC976B.4C1A9234-ON85256C30.007406E9@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Tue, 10 Sep 2002 16:08:31 -0500
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 09/10/2002 05:08:32 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project test suite LTP-20020910.tgz has been released.
Visit our website ( <http://ltp.sourceforge.net> ) to download the latest
version of the testsuite, and for information on test results on
pre-releases,
release candidates & stable releases of the kernel. There is also a list
of test cases that are expected to fail, please find the list at
<http://ltp.sourceforge.net/expected-errors.php>

The highlights of this release are:

- New "utils" section created and added to the CVS tree.  This repository
  will hold various utilities, including kernel coverage analysis tools
  and STAX execution scripts.

- LTP website has been modified to contain detailed information about
  kernel code coverage, including details on lcov (LTP's GCOV extension)
  and documentation on how to use lcov for generating coverage
  information.

- New test driver created that runs over the STAf eXecution (STAX) service
  of the Software Test Automation Framework (STAF)
  <http://staf.sourceforge.net>. The driver is available to download from
  the "Utilities" category of the Files section, as well as the "utils"
  section of the CVS tree.

- Documentation on configuration and use of the new STAX LTP driver, with
  screenshots, posted on LTP website.

We encourage the community to post results, patches, or new tests on our
mailing list, and to use the CVS bug tracking facility to report problems
that
you might encounter. More details available at our web-site.


Change Log
------------
- Fix path in runpan.sh                          ( Paul Larson )
- runtest/syscalls:
        a.Removed the {} from the environment    ( Robbie Williamson )
          variables
        b.Comment out stime01, since it sets     ( David Barrera )
          the system time forward and could
          cause problems with several other
          tests if it's running at the same
          time (-x nn)
- Renamed the fsx-linux test on nfs to           ( Robbie Williamson )
  "nfsx-linux"
- fsxtest: Added code to handle JFS.             ( Robbie Williamson )
- ld01: Made the diff case insensative for       ( Robbie Williamson )
  cross-platform compatibility.
- Removed obsolete test, "ulimit", from          ( Robbie Williamson)
  automatic build and install.
- Moved the 'chown' commands to "install"        ( Robbie Williamson )
  section in 'Makefile' of fchmod tests
- Applied patches for s390                       ( Susanne Wintenberger )
- Applied patches for IA64                       ( Jacky Malcles )
- Applied patch for adding some missing includes ( Andreas Jaeger )
  to remove warnings about missing prototypes
- Applied x86-64 patch for ldd01                 ( Andreas Jaeger )
- Fix for ar01 hang when filesystem is full      ( Paul Larson )
- Make ltp run with uClibc                       ( Steven J. Hill )
- Fix compiler warnings in various tests         ( Xiao Feng Shi )
- Clean up many of the mktemp warnings           ( Paul Larson )
  And use mkstemp in tst_tmpdir()
- Applied pan/logfile/tools patches.             ( William J. Huie )
- Use regular instead of mandatory locks in      ( Matthew Wilcox )
  fcntl09, fcntl10, fcntl11 to fix with NFS
- Fix pids in fcntl11, fcntl19, fcntl20, fcntl21 ( Paul Larson )
  to be pid_t instead of short for 2.5 compat
- Add command line options to runalltests.sh to  ( Randy Hron,
  allow setting of various pan options and         Paul Larson,
  changing the temp directory                      Nate Straz )
- Added automation script documentation          ( Jeff Martin )
  to /doc directory.
- Patched nanosleep02.c to correctly test the    ( Andrea Arcangeli )
  functionality and avoid false positives.

- Robbie

Robert V. Williamson <robbiew@us.ibm.com>
Linux Test Project
IBM Linux Technology Center
Phone: (512) 838-9295   T/L: 638-9295
Fax: (512) 838-4603
http://ltp.sourceforge.net


