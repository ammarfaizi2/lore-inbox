Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268255AbUJGWXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268255AbUJGWXG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUJGWW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:22:29 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:5072 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269859AbUJGWTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:19:12 -0400
Subject: [ANNOUNCE] October Release of LTP now available
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
       ltp-announce@lists.sourceforge.net
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF944502BF.97D1185A-ON85256F26.007A6594-86256F26.007A94A2@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Thu, 7 Oct 2004 17:18:54 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.0.2CF2 HFB2|August 27, 2004) at
 10/07/2004 18:18:55
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Changes in the October LTP release:

LTP-20041007
- Applied fix from patch 1037010, submitted by mator.
- Changes from Kris Wilson on RH specific changes
- Changes from the security team testcases
- Add HOWTO for pci tests
- Changes for pci testcases
- Disable -std=c99 and -peandtic flags in writetest's Makefile.  Some users
of very old gcc versions
  had problems with this, but it looks like those versions of gcc will
still compile it ok.
- Fix typo and add log statement if a failure on loading the test module
- Changes requested from the security team for fix PPC64 error
- Small fix to chown03 and fchown04.  tst_tmpdir() call was happening in a
spot that would cause
  it to break under certain automation environments.
- un-spamify fork11 test
- Fix getrlimit02.  Rajeev Tiwari <rajeevti@in.ibm.com> pointed out that
RLIMIT_NLIMIT was now too
  low in the usr include files for newer kernels to cause this to fail.
Defined a new high one that
  ought to work for the forseeable future.
- Overhaul madvise02.  Removed some invalid testcases, fixed one case that
was an invalid failure, and a lot of cleanup
- Changes from SuSE for mincore tests
- Changes from Ihno for Itainium failures
- Changes from SuSE for setdomainname tests
- Changes submitted from SuSE for sethostname
- Changes to fix statfs03 error on trying to write to protected directory
- Change to fix defect 10947, failure on tmp directory
- Applied IA64 specific patch from Jacky Malcles:


Linux Test Project
Linux Technology Center
IBM Corporation


Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

