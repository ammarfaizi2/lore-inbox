Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267231AbUHVONL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267231AbUHVONL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 10:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267234AbUHVONL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 10:13:11 -0400
Received: from mazurek.man.lodz.pl ([212.51.192.15]:59012 "EHLO
	mazurek.man.lodz.pl") by vger.kernel.org with ESMTP id S267231AbUHVONG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 10:13:06 -0400
Date: Sun, 22 Aug 2004 16:12:21 +0200 (CEST)
From: Piotr Goczal <bilbo@mazurek.man.lodz.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Promise Fast Track SX6000 i2o driver.
In-Reply-To: <1093173914.24272.45.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0408221606520.2571@mazurek.man.lodz.pl>
References: <Pine.LNX.4.58.0408211012500.2571@mazurek.man.lodz.pl>
 <1093173914.24272.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-mazurek.man.lodz.pl-MailScanner-Information: Please contact bilbo@man.lodz.pl
X-mazurek.man.lodz.pl-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004, Alan Cox wrote:

Hi,

Thanks for quick answer!

> > With new version of firmware (Bios version 1.20.0.27) driver doesn't 
> > recognise hardware at all. The problem is: Promise's changed PCI_CLASS 
> > identifier from 0x0e00 (I2O controler) to 0x0104 (RAID bus controller). 
> > I've tried simply change PCI_CLASS number in source and recompile it but 
> > it doesn't work good (driver recognised hardware but hung whole machine!).
> The new firmware isn't I2O any more. I've not found any public docs on
> the newer firmware interface and since it was way slower than the 3ware
> card I never looked.

The Promise driver (distributed via src) is common and is working for both 
version of firmware.

So, as I've understood: there will be no working i2o drivers for SX6000 at 
least to time when Promise publicize documentation to their hardware. 
:-( Am I right? 

Best regards

Piotr Goczal
