Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275118AbTHMOYj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 10:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275092AbTHMOYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 10:24:39 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:49851
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S275118AbTHMOYh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 10:24:37 -0400
Date: Wed, 13 Aug 2003 10:24:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
Message-ID: <20030813142436.GA3588@gtf.org>
References: <Pine.LNX.4.10.10307221852030.8687-100000@master.linux-ide.org> <1058956331.5520.13.camel@dhcp22.swansea.linux.org.uk> <20030813133437.GA27182@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813133437.GA27182@ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 03:34:37PM +0200, Vojtech Pavlik wrote:
> On Wed, Jul 23, 2003 at 11:32:11AM +0100, Alan Cox wrote:
> > On Mer, 2003-07-23 at 02:59, Andre Hedrick wrote:
> > > I have already cut all ties with Promise so here is the deal.
> > > I no longer have to count the number of fingers on my hand between hand
> > > shakes.  IE no extras and not shortages.
> > 
> > Thats ok - now they are doing GPL drivers themselves they don't need
> > you any more.
> > 
> > Promise did a SCSI CAM driver because their hardware can queue commands
> > without TCQ - which drivers/ide can't cope with. Otherwise I'd just have
> > used the same type of changes the FreeBSD people did for 2037x.
> > 
> > Its also interesting because it has a hardware XOR engine.
> 
> I don't think it does. The Promise SATA150 SX4 is the one that has the
> XOR engine (and the PDC20621 chip) and that one is not supported by the
> driver.

hmm, the method of delivering ATA and XOR packets on Promise hardware
are very, very similar.  And pdc-ultra driver seems to have code to
deliver XOR packets...

	Jeff



