Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269151AbUIHVKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269151AbUIHVKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 17:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269153AbUIHVKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 17:10:41 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:14486 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269151AbUIHVKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 17:10:39 -0400
Subject: [ANNOUNCE] Sept LTP Release now available
To: linux-kernel@vger.kernel.org, ltp-lists@lists.sourceforge.net,
       ltp-announce@projects.sourceforge.net
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF92FFE664.CC10D58B-ON85256F09.00740AD6-86256F09.00744FC7@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Wed, 8 Sep 2004 16:10:27 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.0.2CF2 HFB2|August 27, 2004) at
 09/08/2004 17:10:29
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





The Sept. release of LTP is now on SourceForge.net, changes include:

LTP-20040908
- Modified runalltests.sh to call runltp.sh. runalltests.sh is now
deprecated and will be removed early next year.
- Modified tst_tmpdir to ensure 777 permissions on test directory.
- Changes to ltp-aiodio.part3 for testcase run parameters
- Changes for 2.6.X so only delete modules is run, query and create are
obsolete
- Updated runtest scenario with the latest SCTP tests.
- uncommented swapon() tests.
- added new paging tests, mincore and madvise
- Change to fix aio-stress problem will io errors on a short read during
the random read portion
- Change to only print out a pass/fail instead of # of iterations pass/fail
- Added IA64 specific code for shmt09.
- Change to not do /dev/ptmx group write on arm arch.
- Applied patch from Ling, Xiaofeng to allow the test to use TDIRECTORY
correctly.
- Corrected test 1 to show EPERM error pointed out by Ling, Xiaofeng.
- Change to close fileHandle prior to cleanup to correct testcase failure
in NFS filesystems
- Change sleep time from 1 second to 10 seconds to allow system to pass
- Change to define RUSAGE_BOTH if not defined, RH removed from user space
and other distros still support.
- Add arm arch to the ALIGNED typedefs
- Changes from Ihno for llseek01.c to check TEST_RETURN vs TEST_ERRNO
- use ltp functions in f00f test for better output parsing
- Fix Makefile to link open_files into the bin directory
- Get rid of extra = of "must be Root user" check
- Change the awk $4 to an $NF to support debian only returning 3 terms
- Change to tcpdump to check IFNAME define


Linux Test Project
Linux Technology Center
IBM Corporation


Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

