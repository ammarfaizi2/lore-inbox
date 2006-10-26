Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965266AbWJZBmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbWJZBmv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 21:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965272AbWJZBmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 21:42:50 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:32997 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S965266AbWJZBmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 21:42:49 -0400
Date: Thu, 26 Oct 2006 10:42:23 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: Generic platform_device libata driver, take 2.
Message-ID: <20061026014223.GA4813@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20061023065907.GA22029@linux-sh.org> <20061023164220.GA24471@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023164220.GA24471@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 05:42:21PM +0100, Russell King wrote:
> On Mon, Oct 23, 2006 at 03:59:07PM +0900, Paul Mundt wrote:
> > This is the second attempt at a generic platform_device libata driver,
> > attempting to take in to account issues raised by Matthias Fuchs and rmk.
> > 
> > Changes in this version include adding a small pata_platform.h header for
> > the private data (which at the moment is limited to a register shift
> > that's needed by ARM), though other things can be added in here if
> > platforms start having other needs.
> 
> Thanks, this will enable me to use this code on ARM.
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
Andrew, can you add this to -mm? No one has raised any other objections
to this particular patch, and without it, IDE on most SH boards is a
no-go.
