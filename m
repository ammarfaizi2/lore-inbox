Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUFCV7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUFCV7s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 17:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbUFCV7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 17:59:47 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:54508 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264389AbUFCV7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 17:59:45 -0400
Subject: [ANNOUNCE] JUne LTP release now available
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF8C996EBE.522F2483-ON85256EA8.0078C716-86256EA8.0078D343@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Thu, 3 Jun 2004 16:59:41 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.0.2CF2 HFB2|May 18, 2004) at
 06/03/2004 17:59:44
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





LTP-20040603
- Minor corrections to the NUM_PROCS patch
- Added the ability to pass NUM_PROCS to the -c option for runalltests.sh
- Fix genload in runalltests.sh, it was trying to run it in all caps, but
the binary is all lower case.
  Should actually run genload now.
- Patch from Alastair McKinstry to allow LTP to build on Linux/HPPA
- Changes for parameters passed to aio-sparse for correct offsets and
restrictions on sizes.
- Add new security tests to syscalls testsuite
- In acl_file_test.c and acl_link_test.c syscalls regarding xattrs are
still
   done via syscall, although libc functions are available. Furthermore I
found
   out that on older distros for non-intel architectures both attr/xattr.h
and
   constants like __NR_getxattr are not available, so in this case the
these
   testcases are not built.
- Updates for the DMPAI testsuite ppc64 support.
- Fix failure on rwtest versions rwtest03 and rwtest04 due to mmap running
out of resources.
- Made changes to get thread ID vs get PID for NPTL threads for unique
filenames where child/parent PIDs are the same.
- Changes to diotest5 and diotest_routines to eliminate random/intermitant
failures on data compare.
- Fixed memory leak in mmstress testcase.
- Changed clone02 to use tid instead of pid to eliminate failures on NPTL
threads(same PIDs for parent/child)
- Changed fcntl15 getpid to gettid (syscall(gettid)) to get unique thread
ID vs common PID in NPTL threads.
- Added adp testcases.


Linux Test Project
Linux Technology Center
IBM Corporation


Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

