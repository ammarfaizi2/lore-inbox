Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310435AbSCPRGX>; Sat, 16 Mar 2002 12:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310209AbSCPRGN>; Sat, 16 Mar 2002 12:06:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46344 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310438AbSCPRGC>; Sat, 16 Mar 2002 12:06:02 -0500
Subject: Re: [PATCH] Natsemi Geode GXn PM support and extended MMX
To: zwane@linux.realnet.co.sz (Zwane Mwaikambo)
Date: Sat, 16 Mar 2002 17:21:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox), davej@suse.de (Dave Jones)
In-Reply-To: <Pine.LNX.4.44.0203161143160.28013-100000@netfinity.realnet.co.sz> from "Zwane Mwaikambo" at Mar 16, 2002 11:44:37 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mHsN-0006jT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> which allows APM to function. Which brings me on to my next question, does 
> APM on Geode GXn work? The datasheet specifies that in order for the 
> processor to enter suspend mode (in response to SUSP# assertion) the first 
> criteria which must be met is that the USE_SUSP bit must be set (CCR2 bit 
> 7). Part two of the patch simply enables extended MMX instructions for the 
> GXn.

Be very careful playing with Cyrix/Geode stuff. In the APM case the BIOS 
is doing the right thing on every box I have ever seen. The extended MMX
one looks right, providing we don't turn it on for any CPU lacking it

