Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbULCWDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbULCWDh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 17:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbULCWDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 17:03:35 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:63371 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262406AbULCWBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 17:01:50 -0500
Subject: [ANNOUNCE] December Release of LTP available
To: linux-kernel@vger.kernel.org, ltp-list@lists.sf.net,
       ltp-announce@lists.sf.net
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFD1A425D5.EF1E32C4-ON85256F5F.0078D558-86256F5F.0078FD7D@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Fri, 3 Dec 2004 16:01:48 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.5.3 HF2 (6.53IBM1)|October
 29, 2004) at 12/03/2004 17:01:49
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





LTP-20041203
- Change to fix file creation error on certain filesystems.
- gf15 and gf18 failed on both 32-bits and 64-bits,
  Growfile used lseek and fstat to operate file. When file grows
  beyond 4G,lseek and fstat would fail on 32-bits machine.
- Added fs-bench by Hironobu SUZUKI and additional JFFS
  testscript by G.BANU PRAKASH.
- Added mongo filesystem test by namesys and additional testscript from
G.BANU PRAKASH.
- Applied patch from Jacky Malcles to allow test to run on IA64.
- settimeofday01 fails on some platforms(ia64,41611   x86-64) occasionally.
  The testcase did not consider the situation when
CONFIG_TIME_INTERPOLATION is enabled.
- Remove case from password query since the distros use both upper and
lower case P/p.


Linux Test Project
Linux Technology Center
IBM Corporation


Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

