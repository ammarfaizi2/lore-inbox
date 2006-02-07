Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWBGVHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWBGVHs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 16:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWBGVHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 16:07:48 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:45960 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932401AbWBGVHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 16:07:47 -0500
Subject: [ANNOUNCE]
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
       ltp-announce@lists.sourceforge.net
X-Mailer: Lotus Notes Release 7.0 HF85 November 04, 2005
Message-ID: <OF66907BA2.5A4794B1-ON8525710E.0073D97F-8625710E.00740DE7@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Tue, 7 Feb 2006 15:07:45 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.5.4FP2 HF4|December 20, 2005) at
 02/07/2006 16:07:46
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The February release of LTP is available on the website --
ltp.sourceforge.net

LTP-20060207
- Added new fcntl() test contributed by Jacky Malcles to test opening with
O_WRONLY
- Fix typo in nfs run script, nfs03 ran twice instead nfs04
- Added the LTP's Database Opensource Test Suite to the testsuite.
- Applied patch from Mike Frysinger that disables ballista if no perl
  is installed on the system and fixes the clean target.
- Applied LDFLAG fix from Mike Frysinger
- Applied patch from Mike Frysinger to ensure Makefile properly respect
CFLAGS/LDFLAGS
- fixed some RH/Suse specific messages
- Updates for mmc security tests
- Updates for device driver testsuites from Amit Khanna (Intel)
- Applied memory leak fix in fsx-linux.c
- Fix for uClinux to fix execute error
- Fix to prevent not enough (pages) dups error in some cases
- Applied patch from Jacky Malcles: during its life fcntl23 has changed:
  used to open the file with O_RDWR and now is opening with O_RDONLY
- Added new fcntl() test contributed by Jacky Malcles to test opening with
O_WRONLY
- Fixed gethostid01 so the second 64 bit check doesn't clobber the first 64
bit check by using a bitmask
- fix for defect 21050, the logic on line 211 was reversed causing the
64bit code to get run on a 64bit system
- Fixes for uClinux to fix fork and invalid memory access errors
- Fix for defect 21072, fixing the offset on some systems
- Applied patch from Mike Frysinger to resolve issue with UNALIGNED being
defined multiple times for ARM targets.
- Patch to fix race condition on 64bit systems, fixes bugzilla 19013
- Fix for defect 21046, testcase should fail ENOMEM passes due to
insufficient pages
- Applied patch from Jane Lv to disable test for uClinux.
- Fix for defect 21065, the kernel changed the return for tests 4 & 9.
Added dual tests on failure so new/old kernels should both pass
- Fix to get rid of ugly messages during the make
- Fix for defect 21068, check for the existance of either syslogd or
syslog-ng before failing and reporting an error
- Applied patch from Mike Frysinger to resolve problem with defining a
local syslog() function when the tests are built statically.
- Fix for defect 20348, waitpid12 hangs occasionally
- Applied patch from Jeff Burke:
  Here is a patch that modifies the following files:
   testcases/network/nfsv4/acl/acl1.c - Fix for segfault in a printf.
   testcases/network/nfsv4/acl/create_users.py - Fix for help syntax
     (backwards -u users -g groups).
   testcases/network/nfsv4/acl/runtest - Fix for useradd command and also
      a echo command.
   testcases/network/nfsv4/acl/test_long_acl.py - Fix for output, the  #
      of entries was munged with the word entries.
- Add sctp testcase updates
- Initial drop of pounder21 testsuite

Marty Ridgeway
Linux Test Project
Linux Technology Center
IBM Corporation

Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 902/6B021
Austin, TX.

