Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUL0QeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUL0QeV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 11:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbUL0QeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 11:34:21 -0500
Received: from bay15-f41.bay15.hotmail.com ([65.54.185.41]:30193 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261925AbUL0QeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 11:34:18 -0500
Message-ID: <BAY15-F419E77AD01BC2D2F7A1149B2990@phx.gbl>
X-Originating-IP: [61.10.7.28]
X-Originating-Email: [mbenz74@hotmail.com]
From: "M Benz" <mbenz74@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: cache and buffer usage with kernel 2.6.10
Date: Mon, 27 Dec 2004 16:33:41 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=big5; format=flowed
X-OriginalArrivalTime: 27 Dec 2004 16:34:16.0530 (UTC) FILETIME=[E821D320:01C4EC31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just upgrade my linux box from 2.6.8.1 to 2.6.10 yesterday, and I found 
that the memory usage behavier is very different btw the 2 kernels. I built 
2.6.10 with the same .config with my 2.6.8.1

My box is a Pentium 4 HT machine, with 2GB of RAM, it's running apache to 
service a very busy website, around 1.5M PHP pageviews per day.

With kernel 2.6.8.1, "top" always show me acount 150MB buffer, 1.3-1.5GB 
cached, and 1-2M free, after switch to  kernel 2.6.10, "top" shows me 
around 500MB buffer, 800M cache, and several MB free. after around 10 hours 
with 2.6.10, top now shows me 800MB buffer, 500MB cache and 2-300MB free.

Is there any change with memory management btw the two kernels? Also, what 
is the different btw "cache" and "buffer"? Why don't kernel 2.6.10 use all 
the memory but leave around 200MB free?

Thanks.

_________________________________________________________________
使用 MSN Messenger，與朋友在線上聊天: http://messenger.microsoft.com/tc 

