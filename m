Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292296AbSBTUjO>; Wed, 20 Feb 2002 15:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292295AbSBTUjF>; Wed, 20 Feb 2002 15:39:05 -0500
Received: from demetrius.hosting.pacbell.net ([216.100.99.31]:13208 "EHLO
	demetrius.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S292293AbSBTUi6>; Wed, 20 Feb 2002 15:38:58 -0500
From: "Adam Khan" <adam.khan@cavium.com>
To: <linux-kernel@vger.kernel.org>
Cc: "'Adam Khan'" <adam.khan@cavium.com>
Subject: FW: where has all the memory gone?
Date: Wed, 20 Feb 2002 12:33:13 -0800
Message-ID: <002e01c1ba4d$db00b7b0$4310a8c0@Adamspc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Im running RH 7.1. I also have FreeSWAN 1.91 and I am making
> modifications to the FS stuff. I have a driver for a card. I am
> extending
> the driver and manage to do a couple of calls without any problems.
> 
> In another routine when I kmalloc 152 bytes of memory the call blocks
-
> When I issue the kmalloc call with GFP_ATOMIC rather than GFP_KERNEL I
> get
> the memory and see IPsec packets received and txd as expected. I issue
> the command "less /proc/meminfo" and it indicates that I have 60 Megs
> MemFree.
> 
> Id appreciate your help to understand why the calls block and what
> I can change/adjust rather that use the GFP_ATOMIC.
> 
> Thanks in advance,
> Adam
> 


