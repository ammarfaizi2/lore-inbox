Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266545AbUHBOoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266545AbUHBOoM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 10:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266548AbUHBOmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 10:42:04 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:30336 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S266572AbUHBOk2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 10:40:28 -0400
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Message-Id: <E2894B16-E491-11D8-94F5-00039398BB5E@ieee.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: Unable to mount DVD-RAM Media read/write on GSA-4040B with Kern
	el
Date: Mon, 2 Aug 2004 08:40:22 -0600
To: Michael Thalmann <mth@herakles.ath.cx>
X-Mailer: Apple Mail (2.618)
X-OriginalArrivalTime: 02 Aug 2004 14:40:21.0805 (UTC) FILETIME=[A3984DD0:01
	C4789E]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:2.95680 C:20 M:0 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael T:

 > prepatch 2.4.27-rc3
 > unable to write to my DVD-RAM Drive, LG GSA-4040B ... mount
 > mke2fs ... works
 > On 2.4.26 i was able

Please tell us what you see in 2.4.27-rc3 when you try:

sudo blockdev --getro /dev/hd*

Pat LaVarre
http://linux-pel.blog-city.com/read/754579.htm

P.S. I found this thread via:

2.4.27rc2, DVD-RW support broke DVD-RAM writes
http://marc.theaimsgroup.com/?t=109043580300002

http://marc.theaimsgroup.com/?l=linux-kernel&s=dvd-ram

