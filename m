Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVBGWYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVBGWYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVBGWYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:24:43 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:33691 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261241AbVBGWYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:24:41 -0500
Subject: [ANNOUNCE] February release of LTP
To: linux-kernel@vger.kernel.org, ltp-list@lists.sf.net,
       ltp-announce@lists.sf.net
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFCF5A51B1.4D3C878A-ON85256FA1.007AF2C1-86256FA1.007B1707@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Mon, 7 Feb 2005 16:24:39 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.53IBM1 HF6|December 9, 2004) at
 02/07/2005 17:24:40
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





The February release of LTP is now available.

LTP-20050207
- runltp now exports $TMPDIR as a copy of $TMP, certain exceptions caused
these to be different.
- extra functions for LTP libs are to make these tests fail with a more
  informative message when attempts to create swap on tmpfs are made.
- IPV6 testcase updates from David Stevens
- Applied patch from Jacky Malcles that fixes an inconsistency regarding
synchronization.
- Make proc01 skip kcore
- Fix gives an hint to the probable solution if capset01 test fails
- Fix for race conditions in synchronization between children and parent on
fcntl15.
- Applied patch from Jacky Malcles to allow test to run on ia64.
- The test llseek sets RLIMIT_FSIZE to a small number, this fix to
  restore it to its original value.
- Fix IPV6 Makefile install path problem


Linux Test Project
Linux Technology Center
IBM Corporation


Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

