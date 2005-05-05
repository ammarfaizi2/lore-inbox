Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVEEUW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVEEUW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 16:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVEEUTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 16:19:46 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:29313 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262172AbVEEUSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 16:18:47 -0400
Subject: [ANNOUNCE]
To: linux-kernel@vger.kernel.org, ltp-list@lists.sf.net,
       ltp-announce@lists.sf.net
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFF0BC5F05.966D5D1B-ON85256FF8.006F7011-86256FF8.006F826D@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Thu, 5 May 2005 15:18:39 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.53IBM1 HF14|April 18, 2005) at
 05/05/2005 16:18:40
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





The May release of the LTP is now available.

LTP-20050505
- Added DBAT testsuite, limited LTP tests for build verification -
runltplite
- fix the bug on test table selinux when run the ltpmenu.
- Added new getpagesize() test.
- New test creates a data file of specified or random size and copies
  the file to a random directory depth on a designated filesystem.
  The two files are compared and checked for differences.
- Make nptl01 timeout and report failure rather than just hanging in the
event of a fail.
- Moved SELinux testsuite from misc to the kernel/security directory.
- acct01 - Updated test to allow for execution on zSeries machines.
- ioperm01 - Fixed bug will cause ioperm01 receive SEGV and report "BROK"
instead of "FAIL" when this test failed.
- nfs04 - use 'cmp' instead of 'diff' because I think byte comparison is
better for the type of file created for this test.
- Fixed ftp01 and telnet01 seems designed to run with non-root user
connection
  when the user name is set to RUSER environment variable.
  However, it is incomplete.ftp01 creates a directory whose permission is
root.
  So, non-root user cannot write in the directory.
  telnet01 always consider the prompt is '#'


Linux Test Project
Linux Technology Center
IBM Corporation


Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

