Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTH0Pau (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTH0Pau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:30:50 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:64672 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263493AbTH0Pas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:30:48 -0400
Subject: Re: [PATCH 2.6][TRIVIAL] Update ide.txt documentation to current
	ide.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mlord@pobox.com,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.51.0308211225120.23765@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0308211225120.23765@dns.toxicfilms.tv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061998172.22825.51.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 27 Aug 2003 16:29:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-21 at 11:30, Maciej Soltysiak wrote:
> + "hdx=biostimings"	: driver will NOT attempt to tune interface speed
> + 			  (DMA/PIO) but always honour BIOS timings.
> +

Please don't document this option except maybe as "Selecting this on
most systems will destroy all your data"

>   "hdx=slow"		: insert a huge pause after each access to the data
>  			  port. Should be used only as a last resort.

Should go - isnt supported any more

> + "hdx=flash"		: allows for more than one ata_flash disk to be
> + 			  registered. In most cases, only one device
> + 			  will be present.

Fixed properly in 2.4, dunno about 2.6

> +
> + "idex=biostimings"	: driver will NOT attempt to tune interface speed
> +			  (DMA/PIO) but always honour BIOS timings.

Replace with "generally randomizes your disk contents, do not ever use"

> + "ide=reverse"		: formerly called to pci sub-system, but now local.
> +

Better if it said what it did ?


Rest looks ok

