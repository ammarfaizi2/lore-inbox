Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWIOUcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWIOUcF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWIOUcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:32:04 -0400
Received: from chain.digitalkingdom.org ([64.81.49.134]:47317 "EHLO
	chain.digitalkingdom.org") by vger.kernel.org with ESMTP
	id S1751399AbWIOUcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:32:02 -0400
Date: Fri, 15 Sep 2006 13:31:59 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Same MCE on 4 working machines (was Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM)
Message-ID: <20060915203159.GS4610@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org> <20060914190548.GI4610@chain.digitalkingdom.org> <1158320742.29932.20.camel@localhost.localdomain> <20060915182915.GR4610@chain.digitalkingdom.org> <1158353439.29932.146.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158353439.29932.146.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
From: Robin Lee Powell <rlpowell@digitalkingdom.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 09:50:39PM +0100, Alan Cox wrote:
> Ar Gwe, 2006-09-15 am 11:29 -0700, ysgrifennodd Robin Lee Powell:
> > > 	pci=conf2
> > 
> > No effect without acpi=off.
> > 
> > With acpi=off, it gets rather farther before apparently failing to
> > talk the 3-ware card:
> 
> Thats helpful. The conf2 cycles are the wrong type for the board
> so with acpi=off pci=conf2 it doesn't see any PCI devices and
> doesn't explode. I see nothing odd in the lspci data at all
> however.
> 
> You also have a lot of RAM, that shouldn't matter but it means you
> hit code paths most users don't. If you boot with mem limited to
> 1GB I assume it still blows up ?

I've tried mem=1023M, yes, and it still blows up.  Just did acpi=off
mem=1023M to check.

-Robin
