Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264795AbSLJV17>; Tue, 10 Dec 2002 16:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbSLJV17>; Tue, 10 Dec 2002 16:27:59 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:56279 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264795AbSLJV15>;
	Tue, 10 Dec 2002 16:27:57 -0500
Message-ID: <3DF65DF8.1050601@us.ibm.com>
Date: Tue, 10 Dec 2002 15:34:48 -0600
From: Jeff Martin <ffej@us.ibm.com>
Reply-To: ffej@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] ltp-20021210 released.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project test suite LTP-20021210.tgz has been released.
Visit our website (http://ltp.sourceforge.net) to download the latest
version of the testsuite, and for information on test results on
pre-releases, release candidates & stable releases of the kernel. There
is also a list of test cases that are expected to fail, please find
the list at (http://ltp.sourceforge.net/expected-errors.php)

The highlights of this release are:

- Many new test from Wipro.

- New SPIE tests ported. Special thanks to Gerrit Huizenga and Narasimha 
Sharoff
  for getting us the SPIE tests.

We encourage the community to post results, patches, or new tests on our
mailing list, and to use the CVS bug tracking facility to report problems
that you might encounter. More details available at our web-site.


Change Log
----------

- Added 5 new sched_setparam() tests              ( Saji Kumar )
- Added new syslog() tests.                       ( David Barrera )
- Fix compile errors with *_module tests          ( Paul Larson )
- Added additional semctl tests, semctl06 and     ( David Barrera )
  semctl07.
- Added additional msgctl tests.                  ( David Barrera )
- Added mkdir09.                                  ( David Barrera )
- Added mem02.                                    ( David Barrera )
- Added floating point tests, fptest01, fptest02, ( Jacky Malcles )
  fptest03.
- Added inode01 and inode02                       ( Robbie Williamson )
- Added vmtests, data_space and stack_space.      ( Robbie Williamson )
- Added page tests, page01 and page02.            ( Robbie Williamson )
- Added sysconf() test.                           ( Robbie Williamson )
- Added rename14                                  ( Robbie Williamson )
- Added nftw() tests.                             ( Robbie Williamson )
- Added confstr() test.                           ( Robbie Williamson )
- Added acct() tests.                             ( Robbie Williamson )
- Added flock03 to try relocking after unlocking. ( Paul Larson )
  To reproduce bug #7 in osdl's bugzilla.
- Corrected a typo in ar01.  A "=" was used,      ( Robbie Williamson )
  instead of an "==" found by Airong Zhang.
- Added 3 new sched_getparam tests                ( Saji Kumar )
- Added query_module() tests                      ( T.L.Madhu )
- Added 2 new flock() tests                       ( Vatsal Avasthi )
- Added munlock() tests                           ( Nirmala Devi 
Dhanasekar )
- Added umount() tests                            ( Nirmala Devi 
Dhanasekar )
- Added mount tests                               ( Nirmala Devi 
Dhanasekar )
- Added 2 new tests for sched_get_priority_min    ( Saji Kumar )
- Added 2 new tests for sched_get_priority_max    ( Saji Kumar )
- patch for sched_setscheduler01 to add           ( Saji Kumar )
  a test case for calling sched_setscheduler()
  with an invalid priority
- Added mlockall() tests                          ( Nirmala Devi 
Dhanasekar )
- Added delete_module tests                       ( T.L.Madhu )
- fix to readlink04.c. was creating a             ( Robbie Williamson )
  testfile called "testfile" in /, instead of the
  temp dir created for the test.
- Added getdomainame test                         ( Saji Kumar )
- warning cleanup patches. removed additional     ( Saji Kumar )
  warnings created when -Wall option used.
  also fixed Makefiles to correctly locate
  the libraries and header files necessary for
  compilation.
- Added 6 new clone() tests                       ( Saji Kumar )
- PPC fixes to ar, semctl04, and read02           ( Anton Blanchard )
- MULTIPLE cleanups and fixes                     ( Ihno Krumreich )
- Increased the default setting for MAXIDS number ( Robbie Williamson )
  to 2048 in semget05.
- Test was running to /dev/tty3, which does not   ( Robbie Williamson )
  exist on some Linux installations. changed it
  to /dev/tty for better general use.
- Added create_module tests                       ( T.L.Madhu )
- patch to cleanup warnings in syscall tests      ( Saji Kumar )
- Corrected typo in rusers01                      ( Robbie Williamson )
- Replaced sigset() with sigaction() in write04.  ( Manoj Iyer )


-Jeff

Jeff Martin (ffej_AT_us.ibm.com)
Linux Test Project
IBM Linux Technology Center
http://ltp.sourceforge.net

