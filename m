Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUJRVT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUJRVT3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 17:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267404AbUJRVRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 17:17:01 -0400
Received: from [80.125.88.152] ([80.125.88.152]:11138 "EHLO tapa-port1")
	by vger.kernel.org with ESMTP id S267417AbUJRVOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 17:14:21 -0400
From: Jkx <jkx@larsen-b.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: SiS 162 USB Wifi chipset support
Date: Mon, 18 Oct 2004 23:14:32 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410182314.32861.jkx@larsen-b.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, 

I don't know if this is the right place to post this, so feel free
to send me the right address. 

I just buy a Netgear Wifi USB stick (MA111v2). The previous 
version of this stick (v1) is compliant with wlang-ng, but this
new serie use SiS 162 chipset. 

After a little googling, i found that SiS supply a kernel module
(a .c wrapper + a binary .o) at http://driver3.sis.com/linux/wlan/

This kernel module isn't compliant w/ the kernel 2.6.X. I'm not 
a kernel guru, but it seems to use a old task queue and irq handling. 

While this piece of code should'nt take too much work to port 
on a recent kernel, I'm wondering what to do. In fact the copyright
notice is:  Copyright (c) Silicon Intergrated System Inc. That's all ..
So I guess this couldn't be integrated in kernel ? 

So my question is: In this special case, what should I do ? 
(I 'm unable to find a contact a SiS ..)



Thanks for any help 


(apologize for my awfull english .. ) 


