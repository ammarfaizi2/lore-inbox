Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311614AbSDOLYQ>; Mon, 15 Apr 2002 07:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312279AbSDOLYP>; Mon, 15 Apr 2002 07:24:15 -0400
Received: from [163.16.4.8] ([163.16.4.8]:2828 "EHLO kalug.ks.edu.tw")
	by vger.kernel.org with ESMTP id <S311614AbSDOLYP>;
	Mon, 15 Apr 2002 07:24:15 -0400
Date: Mon, 15 Apr 2002 19:04:54 +0800 (CST)
From: Rex Tsai <chihchun@kalug.linux.org.tw>
To: linux-kernel@vger.kernel.org
cc: Andy Jeffries <lkml@andyjeffries.co.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andre Hedrick <andre@linux-ide.org>
Subject: HPT372A with DMA support ?
Message-ID: <Pine.LNX.4.10.10204151854270.25849-100000@kalug>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, I have a HighPoint RocketRAID 133 with HPT372A chipset. 
(firmware revision is 2.31)

My currect kernel version is 2.4.19-pre5-ac3, this version contains 
HighPoint "366", "366",  "368", "370", "370A", "372", "374" support.

When booting with this kernel I get "hde lost interrupt",  I tried
hacking the ide drivers myself a little. Now, it works without DMA
support, I submit my patch to linux kernel mailing list. here is the
patch http://marc.theaimsgroup.com/?l=linux-kernel&m=101848841720406&w=2

I still trying to improve on DMA support. Can you offer me 
any help ? ex. data sheet, manual, driver source code, etc ? 

Best Regards, 
Rex Tsai, <chihchun_at_kalug.linux.org.tw>

