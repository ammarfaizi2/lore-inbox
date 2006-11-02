Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWKBADS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWKBADS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309AbWKBADS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:03:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48101 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750885AbWKBADR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:03:17 -0500
Date: Wed, 1 Nov 2006 16:02:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Stoffel <john@stoffel.org>, Jeff Garzik <jeff@garzik.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] libata fixes
Message-Id: <20061101160207.6b5e4c29.akpm@osdl.org>
In-Reply-To: <1162391435.11965.128.camel@localhost.localdomain>
References: <20061101021301.GA21568@havoc.gtf.org>
	<17736.43507.649685.484648@smtp.charter.net>
	<1162391435.11965.128.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2006 14:30:35 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Mer, 2006-11-01 am 09:06 -0500, ysgrifennodd John Stoffel:
> > Jeff> +	{ 0x8086, 0x7110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
> > Jeff>  	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
> > 
> > Umm, according to lspci -nn on my 440GX box, isn't the 0x8086/0x7110
> > an ISA bridge, not a PIIX? controller?  
> 
> Correct - the 7110 doesn't belong on that list.

So should it be moved elsewhere, or simply removed?
