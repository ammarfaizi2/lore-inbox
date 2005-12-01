Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbVLAW6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVLAW6W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 17:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbVLAW6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 17:58:22 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:27086 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932537AbVLAW6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 17:58:21 -0500
Message-ID: <438F800C.1050903@comcast.net>
Date: Thu, 01 Dec 2005 17:58:20 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: pci unsupported PM regs version (7), means hardware isn't working?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting this warning when i try to load the madwifi drivers on my 
WRAP board for the WMIA-166AG mini-pci card using kernel 2.6.13.3 and 
the latest trunk of madwifi.  

This is the only error that's printed before the HAL driver for madwifi 
responds with "no hardware found or unsupported hardware" etc etc.   I 
had to add the pcid's to madwifi for it to even detect it enough to try 
and send it to the HAL module, but the madwifi dev team isn't looking at 
any bug reports because of this printk that's being made by the PCI 
subsystem in the kernel. 

So, does this printk mean anything (i've seen posts where the hardware 
producing it was working, the printks were just a nuissance) or does it 
indicate some issue the PCI subsystem is having in powering the card up 
and communicating with it.   In either case, I'd be more than happy with 
providing anyone able to patch the pci code with information i have on 
the card. 

If it's nothing but a harmless warning, i'll forward the response to the 
madwifi wiki and mailing list, so something can be done upstream to the 
hal module to work the card. 

Thanks in advance. 


