Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbTHVL17 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 07:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbTHVL17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 07:27:59 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:59532 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id S263100AbTHVKqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 06:46:42 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200308221044.h7MAicrR005239@wildsau.idv.uni.linz.at>
Subject: Re: usb-storage: how to ruin your hardware(?)
In-Reply-To: <1061449894.3029.1.camel@dhcp23.swansea.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 22 Aug 2003 12:44:38 +0200 (MET DST)
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Iau, 2003-08-21 at 02:34, H.Rosmanith (Kernel Mailing List) wrote:
> > hi,
> > 
> > just today, I bought an "USB BAR", a 128MB flash disk. I managed to make
> > the device unusable and only get scsi-errors from it.
> 
> Are you sure it didnt just fail. The report you give basically says

I don't know, probably.

> "after the first write the flash device failed entirely". That doen't 

no, I wrote several data to it, like partitioning it, writing /dev/zero
to it and so on. I moved it from computer to computer to try booting from
it, installed lilo on it and so on. After several hours of messing around
with the device, it failed.

Maybe it is just "forbidden" to partition it, since I know boldly ;)
did mke2fs /dev/sda on the exchanged flashdev and installed lilo on
it too. So far, no problems yet. Still can't boot from it, however 
(is this an USB-HDD in bios or does the bios have to support some
USB-MEMORY-STICK boot-option?)


> seem an abnormal flash failure mode
> 
