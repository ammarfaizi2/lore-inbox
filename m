Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274837AbTHMNfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274961AbTHMNfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:35:12 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:14248 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S274837AbTHMNfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:35:06 -0400
Date: Wed, 13 Aug 2003 15:34:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>, Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
Message-ID: <20030813133437.GA27182@ucw.cz>
References: <Pine.LNX.4.10.10307221852030.8687-100000@master.linux-ide.org> <1058956331.5520.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058956331.5520.13.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 11:32:11AM +0100, Alan Cox wrote:
> On Mer, 2003-07-23 at 02:59, Andre Hedrick wrote:
> > I have already cut all ties with Promise so here is the deal.
> > I no longer have to count the number of fingers on my hand between hand
> > shakes.  IE no extras and not shortages.
> 
> Thats ok - now they are doing GPL drivers themselves they don't need
> you any more.
> 
> Promise did a SCSI CAM driver because their hardware can queue commands
> without TCQ - which drivers/ide can't cope with. Otherwise I'd just have
> used the same type of changes the FreeBSD people did for 2037x.
> 
> Its also interesting because it has a hardware XOR engine.

I don't think it does. The Promise SATA150 SX4 is the one that has the
XOR engine (and the PDC20621 chip) and that one is not supported by the
driver.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
