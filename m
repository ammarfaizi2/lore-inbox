Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTJ0SK4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 13:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbTJ0SK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 13:10:56 -0500
Received: from vic20.blipp.com ([217.75.101.38]:29583 "EHLO vic20.blipp.com")
	by vger.kernel.org with ESMTP id S263459AbTJ0SKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 13:10:54 -0500
Date: Mon, 27 Oct 2003 19:10:53 +0100
From: Patrik Wallstrom <pawal@blipp.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA and 2.6.0-test9
Message-ID: <20031027181052.GG32168@vic20.blipp.com>
References: <20031027141531.GD15558@vic20.blipp.com> <20031027165809.GD19711@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027165809.GD19711@gtf.org>
Organization: Foodfight Stockholm
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003, Jeff Garzik wrote:

> > > Jeff Garzik:
> > >   o [libata] Merge Serial ATA core, and drivers for
> > >   o [libata] Integrate Serial ATA driver into kernel tree
> > 
> > I am happy to see these in the kernel now, but I have yet to get them
> > working on my KT6 Delta KT600 motherboard with the VT8237 SATA
> > southbridge controller or even the Promise controller.
> 
> Does it improve things, if you change ATA_FLAG_SRST to
> ATA_FLAG_SATA_RESET, in drivers/scsi/sata_via.c ?

It doesn't hang any more, but the only result is:
sata_via version 0.11
ata3: SATA max UDMA/133 cmd 0xD800 ctl 0xD402 bmdma 0xC800 irq 16
ata4: SATA max UDMA/133 cmd 0xD000 ctl 0xCC02 bmdma 0xC808 irq 16
ata3: thread exiting
scsi2 : sata_via
ata4: thread exiting
scsi3 : sata_via

-- 
patrik_wallstrom->foodfight->pawal@blipp.com->+46-733173956
                `-> http://www.gnuheter.com/
