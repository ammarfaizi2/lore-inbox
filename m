Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVFHUDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVFHUDh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 16:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVFHUDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 16:03:00 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:52162 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261590AbVFHUCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 16:02:20 -0400
X-Mailer: Lotus Notes Release 6.5.3 September 14, 2004
MIME-Version: 1.0
Subject: [ANNOUNCE] June Release of LTP available
To: <linux-kernel@vger.kernel.org>, <ltp-list@lists.sf.net>,
       <ltp-announce@lists.sf.net>
Message-ID: <OF5E131C2E.49F79ABF-ON8525701A.006D7BDE-8625701A.006E0D09@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Wed, 8 Jun 2005 15:02:09 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.53IBM1 HF14|April 18, 2005) at
 06/08/2005 16:02:13,
	Serialize complete at 06/08/2005 16:02:13
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





LTP-20050608
- Added test for getcontext()
- Added additional test for mlockall().
- Added getdtablesize() test.
- Added pselect01 test.
- Added new fcntl tests to scenario.
- fs_inod - Raised the maximum file size for the random setting to 500Mb.
- upgrade disktest to version 1.2.8
- Clearify the comment explaining the second call to alarm() in
  testcases/kernel/syscalls/alarm/alarm06.c
- Corrected a bug in fcntl24.c and added new tests fcntl25, fcntl26, and
fcntl27.
- Change to 1024 default if IO_BITMAP_BITS not defined
- Applied fix for conditions where ENOMEM test scenarios were failing.
- mlockall03 is a Test for checking basic error conditions for mlockall(2)
  starting from linux 2.6.9
- NGROUPS_MAX defined in limits.h is not the max number of groups in the
  system, it the max number guaranteed.  Thus, if the system actually
  allows more, the test case doesn't produce the expected failure.
- test3 in setrlimit02.c:Test attempts to increase hard limit of
RLIMIT_NOFILE resource.
  The rlim_max used by setrlimit() is expected to be greater than current
hard limit to get EPERM.
- nfsstress - Corrected so the test can find gettid()'s definition.
- PTS Version 1.5.1 Released
- Removed old version of Open POSIX Test Suite (OPTS).
- Updated the open_posix_testsuite:

Marty Ridgeway
Linux Test Project
Linux Technology Center
IBM Corporation

Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

