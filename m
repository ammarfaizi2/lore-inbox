Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbTLTDHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 22:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTLTDHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 22:07:18 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:1550 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263768AbTLTDHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 22:07:14 -0500
Date: Fri, 19 Dec 2003 18:59:36 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, khc@pm.waw.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] ide.c as a module
In-Reply-To: <20031219090541.10fae126.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.10.10312191857550.7879-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bartlomiej,

There is a way, you just need to use a bigger hammer.
But if you are going to rootwad ./drivers/ide, I want the satisfaction of
MAD (mutual assured destruction!)

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 19 Dec 2003, Randy.Dunlap wrote:

> On Fri, 19 Dec 2003 17:26:46 +0100 Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> 
> | On Thursday 18 of December 2003 01:29, Krzysztof Halasa wrote:
> | > BTW: modular IDE in 2.4.23 is still problematic - you can't unload the
> | > chipset driver (piix.o or something like) which in turn references the
> | > core IDE module.
> | 
> | It is probably too much work to fix it (properly) in 2.4.x and 2.6.x...
> | 
> | Please note that there is no refcounting in IDE drivers,
> | there is no host object type, also table of IDE ports (ide_hwifs[]) is static.
> | 
> | I hope 2.7 will obsolete drivers/ide...
> 
> in favor of libata or what?
> 
> --
> ~Randy
> MOTD:  Always include version info.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

