Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTGGAcw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 20:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTGGAcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 20:32:52 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:31756
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263279AbTGGAcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 20:32:51 -0400
Date: Sun, 6 Jul 2003 17:42:08 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tomas Szepe <szepe@pinerecords.com>,
       Ryan Mack <lists@mackman.net>,
       Markus Plail <linux-kernel@gitteundmarkus.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 ServerWorks DMA Bugs
In-Reply-To: <20030706184242.A20851@ucw.cz>
Message-ID: <Pine.LNX.4.10.10307061740150.29935-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Caution!

Serverworks has OEM's who have BIOS's which are setup for a reason.
If the BIOS is configured for any reason the the driver stomps on the BIOS
settings there will be damage to the content on the media.

Just the view from an insider in the know.

Andre Hedrick
LAD Storage Consulting Group

On Sun, 6 Jul 2003, Vojtech Pavlik wrote:

> On Sun, Jul 06, 2003 at 12:38:11PM +0100, Alan Cox wrote:
> > On Sul, 2003-07-06 at 12:10, Tomas Szepe wrote:
> > > Also note that when the '-X' switch is omitted (i.e. one only issues
> > > "/usr/sbin/hdparm -d1 /dev/hdX"), the driver sets up a mode that doesn't
> > > work and then quickly falls back to PIO.
> > 
> > Your BIOS has not tuned the drive for DMA either.
> 
> IMO the driver should do that in that case. There are way too many
> broken BIOSes to make following what they decided to set up worthwhile.
> 
> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

