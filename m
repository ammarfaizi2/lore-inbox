Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTKFRwC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbTKFRwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:52:02 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:41421 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263805AbTKFRvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:51:42 -0500
Subject: [ANNOUNCE] Linux Test Project November Release Announcement
To: ltp-announce@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: ltp-list@lists.sourceforge.net
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OF0836E331.B4960A45-ON85256DD6.005FBD8D-86256DD6.00620206@us.ibm.com>
From: Robert Williamson <robbiew@us.ibm.com>
Date: Thu, 6 Nov 2003 11:51:05 -0600
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 6.0.2CF2 PMR38084
 MIAS5SCKSP SASF5LTQFD GCHU5LFQD5 JHEG5PKRJT MIAS5RMQQF ALEE5RFGW8+|October
 16, 2003) at 11/06/2003 12:51:29
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

   * Updated the LTP stress script to record 'iostat' statistics if
     needed.

   * Updated the SCTP tests to support the current SCTP 2.6 kernel code.

   * Added new NFS test, nfs04, to help test data integrity during copies
     across mounts.

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
- Fixed bugs in runalltests.sh with creating    ( Manoj Iyer )
  the results directory and locating 'pan'.
- Created new NFS test, nfs04, which tests      ( Robbie Williamson )
  file integrity when copying across mounts.
- Updated the SCTP testcases.                   ( Marty Ridgeway )
- Fixed bugs in 'tar' shell tests.              ( Glen Foster )
- Applied patch to 'doio' for machines that     ( Jun Sun )
  have virtually indexed cache and cache
  aliasing problems
- Updated mem01 and mtest01 to execute on s390  ( Robbie Williamson )
  better.
- Added missing parenthesis to mmstress.        ( Manoj Iyer )
- Added code to chown03 & fchown04 to set the   ( Robbie Williamson )
  environment variable, "change_owner", if it
  is not already set.
- Set the clone stack size to 16384 for all     ( Robbie Williamson )
  clone() tests.
- Applied IA64 specific patch to clone04.       ( Jacky Malcles )
- Removed test8 from stat06 b/c it was not      ( Robbie Williamson )
  valid under the SUSv3.
- Added some extra documentation to swapon02    ( Robbie Williamson )
  on how to handle glibc 2.2.5.
- Resolved bug #834027 with sync02.             ( Robbie Williamson )
- Added option to log 'iostat' data during      ( Robbie Williamson )
  testing using "ltpstress.sh".



