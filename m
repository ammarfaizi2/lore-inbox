Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbTEHVsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTEHVsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:48:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:55186 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262163AbTEHVsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:48:20 -0400
Subject: [ANNOUNCE]Linux Test Project May Release Announcement
To: ltp-announce@lists.sourceforge.net, ltp-list@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OFF8BB6AE0.6A208717-ON85256D20.007867AB-86256D20.0078ED68@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Thu, 8 May 2003 16:59:34 -0500
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 05/08/2003 05:58:49 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project test suite ltp-full-20030508.tgz has been
released. Visit our website (http://ltp.sourceforge.net) to download
the latest version of the testsuite that contains 1800+ tests for
the Linux OS.  Our site also contains other information such as:
test results, a Linux test tools matrix, an area for keeping up with
fixes for known blocking problems in the 2.5 kernel releases,
technical papers and HowTos on Linux testing, and a code coverage
analysis tool.

Lists of test cases that are expected to fail for specific architectures
and kernels are located at:
http://ltp.sourceforge.net/expected-errors.php

These lists also contain expected LTP compiler warnings for each
architecture and kernel.

Highlights:

 * An updated and revised HowTo is now posted on the website.

 * Updates to allow build and execution in NPTL environments.

 * Open POSIX Test Suite 0.9.0 merged into test suite.

 * New 'ltpmenu' ncurses-type GUI available.

 * New tests added for device mapper, sockets, and 2.5 timers.

We encourage the community to post results, patches, or new tests on our
mailing list, and to use the CVS bug tracking facility to report problems
that you might encounter. More details available at our web-site.


CHANGELOG
---------
LTP-20030508

- Updated the LTP to build and execute on NPTL    ( Robbie Williamson )
  installed systems
- Applied 'ash' compatibilty patch                ( Dan Kegel )
- Applied "CFLAGS+=" Makefile patch               ( Vasan Sundar )
- Created "/testscripts" directory and relocated  ( Robbie Williamson )
  scripts to it
- Fixed kill problem with genload's stress.c      ( Amos Waterland )
- Added checking for users and sys groups to      ( Robbie Williamson )
  IDcheck.sh. Also, called the script from
  runalltests.sh before executing tests to support
  cross-compiled platforms
- Added 'ltpmenu' GUI                             ( Manoj Iyer
                                                    Robbie Williamson )
- Applied "posixfy" patches                       ( Vasan Sundar )
- Updated runalltests.sh to use -o for            ( Robbie Williamson )
  redirecting output.
- Added code to runalltests.sh to prompt for      ( Robbie Williamson )
  RHOST and PASSWD when running network tests.
- Updated Open POSIX Test Suite header file to    ( Robbie Williamson )
  allow timer tests to build.
- Compiler warnings cleanups.                     ( Robbie Williamson )
- Corrected buffer overflow in inode02.           ( Dan Kegel )
- Updated disktest to 1.1.10 and fixed for        ( Robbie Williamson )
  systems w/o O_DIRECT
- Completed merge of Open POSIX Test Suite 0.9.0  ( Robbie Williamson )
- Applied ia64 specific patches                   ( Jacky Malcles )
- Updated Makefiles to allow use of "-j"          ( Nate Straz )
- Correct fork05 for use in newer glibc/kernels   ( Ulrich Drepper )
- Applied "type" fixes to recvfrom and recvmsg    ( Andreas Jaeger )
- Applied x86_64 specific patches                 ( Andreas Jaeger )
- Applied MSG_CMSG_COMPAT fix for 64bit 2.5       ( Bryan Logan )
  kernels.
- Added new testcase for setegid.                 ( Dan Kegel )
- Modified syslog tests to use test apis          ( Manoj Iyer )
- Added 2.5 timer tests.                          ( Aniruddha Marathe )
- Added Device Mapper tests.                      ( Marty Ridgeway )
- Added sockets tests.                            ( Marty Ridgeway )
- Removed fptest03 due to use of obsolete         ( Robbie Williamson )
  syscalls that perform 48bit math operations




- Robbie

Robert V. Williamson <robbiew@us.ibm.com>
Linux Test Project
IBM Linux Technology Center
Phone: (512) 838-9295   T/L: 678-9295
Fax: (512) 838-4603
Web: http://ltp.sourceforge.net
IRC: #ltp on freenode.irc.net
====================
"Only two things are infinite, the universe and human stupidity, and I'm
not sure about the former." -Albert Einstein


