Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbUDRXOA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 19:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264207AbUDRXOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 19:14:00 -0400
Received: from vse.vse.cz ([146.102.16.2]:61154 "EHLO vse.vse.cz")
	by vger.kernel.org with ESMTP id S264206AbUDRXN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 19:13:56 -0400
Message-ID: <40830BB3.4020302@okac.org>
Date: Mon, 19 Apr 2004 01:13:55 +0200
From: Kamil Okac <kamil@okac.org>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: via 6420 pata/sata controller
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >Bartlomiej Zolnierkiewicz wrote:
 >> On Tuesday 30 of March 2004 15:24, Zdenek Tlusty wrote:
 >>
 >>>hello,
 >>>
 >>>I have problem with via 6420 controller under linux (I have mandrake 9.1
 >>>with kernel 2.4.25 with libata patch version 16).
 >>>This controller has two sata and one pata channels. Sata channel 
works fine
 >>>with libata. My problem is with pata channel. I have pata hard disk 
on this
 >>>controller. Bios of the controller detected this disk but linux did not.
 >>>What is the current status of the driver for this controller?
 >>>Thank you for your time.
 >>
 >>
 >> There are some patches floating around adding support for VT6410
 >> (not VT6420) to generic IDE PCI driver.  This controller may also work
 >> with generic IDE PCI driver (PCI VendorID/ProductID needs to be added
 >> to drivers/ide/pci/generic.h and drivers/ide/pci/generic.c).
 >
 >VT 6420 should be added to via82cxxx.c, since it does the necessary bus
 >setup and such.  AFAICS it is programmed just like all the other VIA
 >PATA controllers.
 >
 >> BTW Does anybody has contacts in VIA?
 >
 >Sure...  I'll check my VT 6420 cards as well.  It should just be another
 >PCI id added to via82cxxx.c.
 >
 >	Jeff
 >

Hello,

I tried to modify via82cxxx.c and .h, but was unsuccessful. Has anyone 
got it to work properly?

   Kamil Okac
