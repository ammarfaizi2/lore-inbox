Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTJBSac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 14:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTJBSac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 14:30:32 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:210 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263452AbTJBSa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 14:30:29 -0400
Subject: [ANNOUNCE] Linux Test Project October Release Announcement
To: ltp-announce@lists.sourceforge.net, ltp-list@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OFEDBFA355.7AE7CD89-ON85256DB3.0061BB6E-86256DB3.0065DED8@us.ibm.com>
From: Robert Williamson <robbiew@us.ibm.com>
Date: Thu, 2 Oct 2003 13:29:30 -0500
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 6.0.2CF2 JHEG5P4HSL
 JBONL5L8FGD MIAS5MHLYW|August 26, 2003) at 10/02/2003 14:29:49
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project test suite <http://www.linuxtestproject.org> has
been released. The latest version of the testsuite contains 2000+ tests for
the Linux OS. Our web site also contains other information such as: test
results, a Linux test tools matrix, an area for keeping up with fixes for
known blocking problems in the 2.5/2.6 kernel releases, technical papers
and HowTos on Linux testing, and a code coverage analysis tool.

Highlights:

  * Updated the LTP stress script to use all installed RAM,
    plus 1/2 swap space by default.

  * Improved test case binary compatibility between NPTL
    and Linuxthreads systems.

  * Updated versions of disktest, the Open HPI test suite, and
    the Open POSIX test suite.

  * Applied more bug fixes, patches, and code cleanups.

We encourage the community to post results, patches or new tests on our
mailing list <ltp-list@lists.sf.net> and use the CVS bug tracking facility
to report problems that you might encounter with the test suite.

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
---------
- Enabled better binary compatibility between   ( Robbie Williamson )
  executions on NPTL and Linuxthreads.
- Created README for device drivers test        ( Marty Ridgeway )
  executions.
- Resolved bugs #807255 & #807400 for fs_maim.  ( Hien Nguyen )
- Updated disktest to version 1.1.12            ( Brent Yardley )
- Corrected the headers for capset and capget.  ( Robbie Williamson )
- Applied IA-64 fix to clone06 and munlock02.   ( Jacky Malcles )
- Fixed compile warning for gettimeofday01.     ( Andreas Jaeger )
- Applied testcase stability patch to pipe()    ( Erik Andersen )
  testcases.
- Fixed rlogin01 and telnet01 so that they      ( Paul Larson )
  correctly detect when they pass.
- Applied updates to the OpenHPI test suite.    ( Kevin Gao )
- Updated the Open POSIX test suite to 1.3.0.   ( Robbie Williamson )
- Changed ltpstress to use all installed RAM    ( Robbie Williamson )
  plus 1/2 swap space by default.


