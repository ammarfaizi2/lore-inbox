Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTKQDEB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 22:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbTKQDEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 22:04:01 -0500
Received: from bay1-f139.bay1.hotmail.com ([65.54.245.139]:52745 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263298AbTKQDD7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 22:03:59 -0500
X-Originating-IP: [194.47.241.220]
X-Originating-Email: [pandroids@hotmail.com]
From: "Laarz Nilsson" <pandroids@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 3 IDE Controllers
Date: Mon, 17 Nov 2003 03:03:53 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F139UfKRfcjcMz0000e44e@hotmail.com>
X-OriginalArrivalTime: 17 Nov 2003 03:03:54.0274 (UTC) FILETIME=[6F4BD820:01C3ACB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a little problem with my fileserver running kernel 2.6.0-test9
I have recently installed a 3rd IDE controller in the box, and Linux doesn't 
find it. I searched the archives for solutions for my problem, and found 
that there's a hardcoded limit in the kernel which only allows 10 IDE 
channels. I tried changing MAX_HWIFS in ide.h and also the name assignment 
code in ide.c, and now the kernel at least finds my controller, though disks 
cannot be used. I get this error during boot:

HPT37X: using 33MHz PCI clock
    idea: BM-DMA at 0x9800-0x9807, BIOS settings: hdu:DMA, hdv:DMA
    ideb: BM-DMA at 0x9808-0x980f, BIOS settings: hdw:DMA, hdx:DMA
...
idea: I/O resource 0xA402-0xA402 not free.
hdu: ERROR, PORTS ALREADY IN USE
hdv: ERROR, PORTS ALREADY IN USE
ideb: I/O resource 0x9C02-0x9C02 not free.
hdw: ERROR, PORTS ALREADY IN USE
hdx: ERROR, PORTS ALREADY IN USE

Is there anyone who have had this problem, and is there a solution for it?

Regards,
Lars

_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

