Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUIINqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUIINqb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 09:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUIINqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 09:46:30 -0400
Received: from users.linvision.com ([62.58.92.114]:45275 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263962AbUIINqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 09:46:16 -0400
Date: Thu, 9 Sep 2004 15:46:14 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97  patch)
Message-ID: <20040909134614.GB27983@harddisk-recovery.com>
References: <20040909114747.GC30162@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909114747.GC30162@lkcl.net>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 12:47:47PM +0100, Luke Kenneth Casson Leighton wrote:
> i was staggered to find that swansmart (smlink.com) have a GPL
> driver for their smart usb 56k modem.
> 
> they also do a pci version: their download supports both (usb+pci)
> 
> they also provide an AC97 ALSA driver (patch is against 2.6.0)
> 
> this PCI ALSA driver is based on the i8x0 / MX 440 modem driver,
> by Jaroslav Kysela <perex@suse.cz>.
> 
> all their code is GPL.  this is very cool.

Most of their code is not GPL'ed. It does have a COPYING file, but that
looks like a BSD license to me. The only (implicitly) GPL'ed part is
the ALSA patch.

> it is available here:
> 
> 	http://www.smlink.com/main/down/slmodem-2.9.9.tar.gz
> 
> i trust that someone will download, check it, and if
> appropriate, incorporate it into the mainstream linux kernel.

It's not a GPL driver, the kernel part contains a binary object file
(drivers/amrlibs.o) so I don't see how it can be included in the main
kernel tree. OTOH, at first glance only the PCI driver needs that
binary blob, the USB driver doesn't.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
