Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266494AbUFUWak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266494AbUFUWak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266495AbUFUWaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:30:35 -0400
Received: from bay17-f22.bay17.hotmail.com ([64.4.43.72]:25606 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266492AbUFUWa3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:30:29 -0400
X-Originating-IP: [143.183.121.3]
X-Originating-Email: [jayrusman@hotmail.com]
From: "Jason Mancini" <jayrusman@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Via C3-2 stepping 6.9.5 + VT8235 ide/dma/network hang
Date: Mon, 21 Jun 2004 15:30:28 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY17-F22ni62UCPvum000250a7@hotmail.com>
X-OriginalArrivalTime: 21 Jun 2004 22:30:28.0949 (UTC) FILETIME=[5B036850:01C457DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm using Mandrake cooker kernel 2.6.7-0rc3.1 on a Via Epia/Eden M10000N
Nehemiah board with 512MB ram and a udma5-capable harddrive.  Looks like the
active drivers are vt82cxxx 3.38 and via-rhine.

1) heavy disk activity: works great for hours (hdparm -m16 -c1 -u1 -d1 -X66)
2) heavy disk activity + network load: hangs and resets, or hangs hard, 
generally within minutes.

Syslog shows dma timeouts, then interrupts lost (machine is dead at that 
point).

Was this ever resolved for other people who were having dma problems with 
the vt8235
southbridge chipset?  I can patch/hack/compile/test if someone wants me to 
try things.

Many Thanks!
Jason Mancini

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar – get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/

