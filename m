Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUFNIYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUFNIYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 04:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUFNIXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 04:23:48 -0400
Received: from mail.dif.dk ([193.138.115.101]:27778 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262114AbUFNIVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 04:21:05 -0400
Date: Mon, 14 Jun 2004 10:20:12 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Ryan Underwood <nemesis-lists@icequake.net>,
       Willy Tarreau <willy@w.ods.org>, twaugh@redhat.com
Subject: Re: Request: Netmos support in parport_serial for 2.4.27
In-Reply-To: <20040613220727.GB4771@logos.cnet>
Message-ID: <Pine.LNX.4.56.0406141013020.7333@jjulnx.backbone.dif.dk>
References: <20040613111949.GB6564@dbz.icequake.net> <20040613123950.GA3332@logos.cnet>
 <Pine.LNX.4.56.0406132225020.5930@jjulnx.backbone.dif.dk>
 <20040613220727.GB4771@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jun 2004, Marcelo Tosatti wrote:

>
> Jesper,
>
> Two more things.
>
> It seems v2.6 also lacks support for this boards:
>
> grep PCI_DEVICE_ID_NETMOS_ *
> pci_ids.h:#define PCI_DEVICE_ID_NETMOS_9735     0x9735
> pci_ids.h:#define PCI_DEVICE_ID_NETMOS_9835     0x9835
> [marcelo@localhost linux]$
>
> Care to prepare a v2.6 version?
>

I don't mind giving it a try, but as I said in my original reply I'm way
out of my league here. First of all I'm not the author of the original
patch, all I did was to try and update it to apply cleanly against
2.4.27-pre5. Secondly I don't have the hardware, so the only testing I can
do is check that it compiles cleanly and then test boot a kernel to see if
it blows up.
But sure, I'll see if I can get it worked into 2.6, that'll be a nice
challenge, but I'll probably be needing some help along the way.


> And two, do we really need to move parport_serial.c to drivers/char in v2.4 ?
>
To be honest, I have no idea.


--
Jesper Juhl <juhl-lkml@dif.dk>

