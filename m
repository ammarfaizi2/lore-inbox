Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270452AbTHGTLE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 15:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270445AbTHGTLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 15:11:03 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:63933 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270373AbTHGTKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 15:10:52 -0400
Subject: [ANNOUNCE] Linux Test Project August Release Announcement
To: ltp-list@lists.sourceforge.net, ltp-announce@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OF77E5815F.8C349051-ON85256D7B.00690616-86256D7B.0068AD18@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Thu, 7 Aug 2003 14:10:34 -0500
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 08/07/2003 03:10:35 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project test suite <http://www.linuxtestproject.org> has
been released. The latest version of the testsuite contains 2000+ tests for
the Linux OS. Our web site also contains other information such as: test
results, a Linux test tools matrix, an area for keeping up with fixes for
known blocking problems in the 2.5/2.6 kernel releases, technical papers
and HowTos on Linux testing, and a code coverage analysis tool.




Highlights:





* Updated and reorganized testcase documentation.


* Rewrite of data generation scripts to allow faster compilation.


* More bug fixes and code cleanups.


* The popular kernel code coverage "galaxy map".


* Picture of Linus Torvalds in our Linux World Expo booth!





We encourage the community to post results, patches or new tests on our
mailing list and use the CVS bug tracking facility to report problems that
you might encounter with the test suite.


See ChangeLog below.

-Robbie

Robert V. Williamson <robbiew@us.ibm.com>
Linux Test Project
IBM Linux Technology Center
Web: http://ltp.sourceforge.net
IRC: #ltp on freenode.irc.net
====================
"Only two things are infinite, the universe and human stupidity, and I'm
not sure about the former." -Albert Einstein



CHANGELOG

- Reorganized and updated the testcase          ( Robbie Williamson )
  descriptions under /doc
- Updated the tst_rmdir API to use        ( Robbie Williamson )
  remove() instead of rmdir().
- Added support for the __ARM_ARCH_4T__   ( Ramesh Subramanian )
  architecture.
- Updated clone() tests to allow them           ( Robbie Williamson )
  to execute on ppc64.
- Created new clone07 test to check for         ( Robbie Williamson )
  glibc bug.
- Rewrote the generate.sh scripts to perl ( Randy Hron
  for faster execution.                     Robbie Williamson )
- Updated "fsstress" to allow setting the ( Robbie Williamson )
  number of loops to run and cleanup options.
- Removed case from diotest4 for read/writes    ( Robbie Williamson )
  with negative counts. Not in SUS.
- Fixed chown03 testcase to allow for better    ( Paul Larson )
  execution stability.
- Added check to mmapstress tests to see if     ( Robbie Williamson )
  roundup() is defined, before defining it.
- Cleaned up sched_stress.                ( Randy Hron )
- Modified diotest4 to test dio to /dev/null    ( Robbie Williamson )
  but not record it as a pass or fail.
- Removed extra "\n"s from creat09.       ( Paul Larson )
- Updated syscall tests that used their own     ( Randy Hron )
  strcpy() definition, instead of string.h's.
- Fixed fchown04 testcase to allow for better   ( Paul Larson )
  execution stability.
- Updated fcntl14 to allow for better execution ( Ramesh Subramanian )
  stability & remove possibility of false fails.
- Applied Xtensa architecture specific patches. ( Joe Taylor )
- Updated memory tests to allow for distros     ( Robbie Williamson )
  that allow non-root users to m(un)lockall
  within the RLIMIT_MEMLOCK resource limit.
- Changed the way munlock02 attempts to access  ( Robbie Williamson )
  outside it's memory space to a more reliable
  method.
- Corrected an expected error return for a case ( Andrew Morton
  in recvmsg01 and sendmsg01.               Paul Larson )
- Corrected compiler warnings in the multicast  ( Robbie Williamson )
  test, mc_opts.
- Corrected syntax error reported in            ( Robbie Williamson )
  Bug #773670.
- Corrected unitialized variable problem in     ( Ramesh Subramanian )
  sendfile01.
- Updated the Open Posix Test Suite to 1.2      ( Robbie Williamson )
- Applied patches to Open HPI Test Suite. ( Kevin Gao )


