Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbVIGT02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbVIGT02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 15:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVIGT02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 15:26:28 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:36038 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751281AbVIGT01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 15:26:27 -0400
Subject: [ANNOUNCE]  Spet release of LTP available
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
       ltp-announce@lists.sourceforge.net
X-Mailer: Lotus Notes Release 6.5.3 September 14, 2004
Message-ID: <OF771BF032.5C6E37A8-ON85257075.006A88C6-86257075.006AADE8@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Wed, 7 Sep 2005 14:25:17 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.5.4FP1 HF2|August 30, 2005) at
 09/07/2005 15:25:43
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change Log is as follows:

LTP-20050907
- Added test for statvfs()
- Applied a load of patches submitted to the mailing list by Gentoo's Mike
Frysinger
- Applied patch from Erik Andersee:
  if __NR_fremovexattr isnt defined by the current linux headers,
  acl_file_test.c will fail to build
- Relocated getcontext() test from getcontext01 to just getcontext.
  Also added the directory to the list of tests not ran on uclinux.
- Applied patch to madvise02 for tmp memory
- Applied patch to mallopt01 to fix logging error.
- fix for defect 17723, change sleep to an at least vs an exact amount
- Correct testcase return on RHEL 3 & 4 2.6.13-rc6-mm1
- Applied IA64 patch received from Jacky Malcles to write03-04
- Added -n option to allow disabling networking stress to ltp-stress

Marty Ridgeway
Linux Test Project
Linux Technology Center
IBM Corporation

Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

