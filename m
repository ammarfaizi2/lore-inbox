Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTLDTAw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 14:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTLDTAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 14:00:52 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:29177 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263587AbTLDTAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 14:00:46 -0500
Subject: [ANNOUNCE] Linux Test Project December Release Announcement
To: ltp-list@lists.sourceforge.net, ltp-announce@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OFB27A6818.F18A4DC2-ON85256DF2.006747E1-86256DF2.006882D5@us.ibm.com>
From: Robert Williamson <robbiew@us.ibm.com>
Date: Thu, 4 Dec 2003 13:01:17 -0600
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 6.0.2CF2 IGS_HF9|October
 28, 2003) at 12/04/2003 14:00:31
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

    * Updated the LTP test driver to handle all real-time signals.

    * Updated the command tests to ensure better portability.

    * Added new NFS test, nfs_fsstress, to stress NFS using the fsstress
test.

    * Added new tests for low-level SCSI, virtual SCSI, Asynch IO, & ACL
control and management

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
- Allowed the test driver to ignore all         ( Robbie Williamson )
  real-time signals.
- Removed the obsolete time() and stime() tests ( Robbie Williamson )
  from the default runalltests.sh and
  ltpstress.sh scripts.
- Updated "file_test.sh" with fixes to improve  ( Glen Foster )
  execution and portability.
- Updated "cpio_tests.sh" with fixes to improve ( Glen Foster )
  execution and portability.
- Updated "cron_tests.sh" with fixes to improve ( Glen Foster )
  execution and portability.
- Updated "mail_tests.sh" with fixes to improve ( Glen Foster )
  execution and portability.
- Added Asynchronous I/O (aio) testcases. ( Marty Ridgeway )
- Added file & directory ACL control and  ( Marty Ridgeway )
  management testcases.
- Added testcases for low-level SCSI & virtual  ( Marty Ridgeway )
  SCSI devices.
- Updated direct IO tests to return TCONF if    ( Robbie Williamson )
  the tested filesystem does not support dio.
- Updated acct01 & sockioctl01 to handle  ( Robbie Williamson )
  situations where /dev/tty0 does not exist.
- Updated fsync02 to ensure max_block is always ( Robbie Williamson )
  greater than data_blocks.
- Updated getgroups03 to allow for better       ( Susanne Wintenberger )
  stability and platform portabilty.
- Updated the modify_ldt testcases to allow the ( Robbie Williamson )
  tests the ability to build on installations
  that use type "user_desc" instead of
  "modify_ldt_s_s".
- Applied IA64 specific fixes to sigaltstack()  ( Jacky Malcles )
  tests.
- Updated some of the utime() tests to sleep    ( Glen Foster )
  longer than one second (2) to ensure proper
  execution on IA64.
- Updated some of the write() tests to make the ( Susanne Wintenberger )
  invalid address test 64bit portable.
- Added new NFS stress test: nfs_fsstress.      ( Robbie Williamson )
- Updated OpenHPI testsuite.              ( Kevin Gao )
- Updated ltpstress.sh to change the maximum    ( Robbie Williamson )
  number of user processes to "unlimited"
  before testing begins (ulimit -u).



