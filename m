Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267565AbUJHQay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUJHQay (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 12:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269792AbUJHQay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 12:30:54 -0400
Received: from mail0.lsil.com ([147.145.40.20]:43728 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S267565AbUJHQaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 12:30:52 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BCADD@exa-atlanta>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Sergey S. Kostyliov'" <rathamahata@ehouse.ru>,
       "Mukker, Atul" <Atulm@lsil.com>
Cc: comsatcat@earthlink.net, linux-kernel@vger.kernel.org
Subject: RE: Megaraid random loss of luns
Date: Fri, 8 Oct 2004 12:30:35 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can try to add the PCI ids for your controllers in megaraid_mbox.c
pci_device_id table. That _should_ work

-Atul

> -----Original Message-----
> From: Sergey S. Kostyliov [mailto:rathamahata@ehouse.ru]
> Sent: Friday, October 08, 2004 12:02 PM
> To: Mukker, Atul
> Cc: comsatcat@earthlink.net; linux-kernel@vger.kernel.org
> Subject: Re: Megaraid random loss of luns
> 
> Hi!
> On Friday 08 October 2004 16:51, Mukker, Atul wrote:
> > I _highly_ recommend to replace the default driver with the latest
> 2.20.4.0
> > driver and retry.
> 
> Unfortunately, version 2.20.4.0 doesn't recognize my AMI megaraid 160
> (Series 475)
> 
> [rathamahata@white megaraid]$ grep Version ./megaraid_mbox.c
>  * Version      : v2.20.4 (September 27 2004)
> [rathamahata@white megaraid]$ /sbin/lspci  | grep Mega
> 02:04.0 RAID bus controller: American Megatrends Inc. MegaRAID (rev 02)
> [rathamahata@white megaraid]$ /sbin/lspci -n  | grep 02:04.0
> 02:04.0 Class 0104: 101e:1960 (rev 02)
> [rathamahata@white megaraid]$
> 
> 
> --
> Sergey S. Kostyliov <rathamahata@ehouse.ru>
> Jabber ID: rathamahata@jabber.org
