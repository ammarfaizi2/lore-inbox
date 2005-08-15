Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVHOHTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVHOHTR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 03:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVHOHTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 03:19:17 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:10450 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932138AbVHOHTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 03:19:17 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Florian Hars <florian@hars.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.4: Continuous Sound from internal speaker from boot to shutdown
Date: Mon, 15 Aug 2005 10:18:39 +0300
User-Agent: KMail/1.5.4
References: <43002D8A.70701@hars.de>
In-Reply-To: <43002D8A.70701@hars.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508151018.39232.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 August 2005 08:52, Florian Hars wrote:
> I have an NForce4 board with an Athlon 64 and use the 2.6.8 kernel from
> the inofficial debian AMD64 port, and everything works, except that the
> proprietary nvidia driver for my geforce card  complains about "Your
> Linux kernel has problems in its implementation of the change_page_attr
> kernel interface" and recommends an upgrade to 2.6.11 or later. Now
> 2.6.11 is out of the question as it does not support lseek(2)
> (archives.neohapsis.com/archives/postfix/2005-01/1205.html), so I tried
> 2.6.12.4 instead. I used the sources from kernel.org and used the
> default for all new options. On boot I get a contionuous sound from the
> internal speaker from a moment shortly after all filesystems are
> mounted. There seems to be no error message related to the sound. In

Sounds like ( ;] ) it's a userspace program or a loaded module.
boot with init=/bin/sh and then reproduce normal boot manually entering
relevant commands (you need to be familiar with boot process - i.e.
you need to know what commands are executed by system while it boots)
until you find out what is it.

> addition, I get a lot of spurious warnings like
> 
> pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS

Output of lspci? lspci -n?
--
vda

