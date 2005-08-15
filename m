Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVHOQKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVHOQKQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbVHOQKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:10:15 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:34969 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S964808AbVHOQKO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:10:14 -0400
Message-ID: <1124122213.4300be659dc89@imp5-q.free.fr>
Date: Mon, 15 Aug 2005 18:10:13 +0200
From: mustang4@free.fr
To: linux-kernel@vger.kernel.org
Subject: Linux Kernel Hang or stop after uncompressing MPC8245
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 57.250.252.246
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I try to boot my linux kernel (with 2.4 or 2.6 it's the same problem) on an
embeded board (EM04N MenMicro) base on a MPC8245 cpu...

When i boot i 've;

> Detected PPCBOOT header
>     Verifying image CRC...ok
>     Uncompressing Multi-File Image ... ok
>     Moving initrd...ok
>     Passing Kernel parameters: root=ramfs console=ttyS0,9600
>     Starting Linux Kernel.
>
and stop here... i must hard reset the board...

Anyone boot a linux kernel on this board ?
I heard about UART serial port problem with MPC8245 cpu, but i don't find a
working solution for patching kernel or setting up correctly...

Anyone can help me ?

I use :
ELDK kit cross compilation for PPC8245
uBoot
and official last kernel source...

Thanks
