Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWFLIPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWFLIPM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWFLIPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:15:12 -0400
Received: from ik55118.ikexpress.com ([213.246.55.118]:17378 "EHLO
	ik55118.ikexpress.com") by vger.kernel.org with ESMTP
	id S1750810AbWFLIPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:15:10 -0400
Message-ID: <448D2274.1060806@free-electrons.com>
Date: Mon, 12 Jun 2006 10:14:44 +0200
From: Michael Opdenacker <michael-lists@free-electrons.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Plans to obsolete register_chrdev()?
References: <44898D29.4030405@free-electrons.com>
In-Reply-To: <44898D29.4030405@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
> In Linux 2.6, character device driver developers are supposed to use 
> alloc_chrdev_region() and cdev_add() instead of register_chrdev(). See 
> http://lwn.net/images/pdf/LDD3/ch03.pdf or 
> http://lwn.net/Articles/126808/ .
>
> However, in 2.6.16, there are still *very few* uses of cdev_add(). 
> Compare http://lxr.free-electrons.com/ident?i=cdev_add to 
> http://lxr.free-electrons.com/ident?i=register_chrdev .
>
> Are there plans to officially obsolete register_chrdev() (in 
> particular through Documentation/feature-removal-schedule.txt)?
>
> Unless register_chrdev() is supposed to stay, I'll be glad to 
> participate in converting character driver code. In particular, would 
> updates to the drivers/chars/mem.c file be welcome?
No answer in 3 days... Does anyone know whether register_chrdev is 
really supposed to go?

If register_chrdev is obsolete, it would be nice to start migrating 
existing character drivers to alloc_chrdev_region() and cdev_add(), and 
I will be glad to help.

TIA,

    Michael.

-- 
Michael Opdenacker, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training
(More than 1000 pages!)

