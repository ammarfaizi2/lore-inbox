Return-Path: <linux-kernel-owner+w=401wt.eu-S1762879AbWLKMlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762879AbWLKMlk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 07:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762880AbWLKMlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 07:41:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2671 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1762879AbWLKMlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 07:41:39 -0500
Date: Mon, 11 Dec 2006 13:41:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: Daniel Drake <dsd@gentoo.org>, Daniel Ritz <daniel.ritz@gmx.ch>,
       Jean Delvare <khali@linux-fr.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: RFC: PCI quirks update for 2.6.16
Message-ID: <20061211124148.GJ10351@stusta.de>
References: <20061207132430.GF8963@stusta.de> <45782774.8060002@gentoo.org> <1165723779.334.3.camel@localhost.localdomain> <20061210160053.GD10351@stusta.de> <1165801368.2987.20.camel@monteirov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1165801368.2987.20.camel@monteirov>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 01:42:48AM +0000, Sergio Monteiro Basto wrote:
> On Sun, 2006-12-10 at 17:00 +0100, Adrian Bunk wrote:
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
> > quirk_via_irq);
> 
> This is back to state of kernel 2.6.16 final (without .x)
> 
> In kernel 2.6.17 final we got
> (http://lkml.org/lkml/2006/4/19/16)
> commit 75cf7456dd87335f574dcd53c4ae616a2ad71a11 
> Author: Chris Wedgwood <cw@f00f.org>
> Date:   Tue Apr 18 23:57:09 2006 -0700 
>     Signed-off-by: Chris Wedgwood <cw@f00f.org>
>     Acked-by: Jeff Garzik <jeff@garzik.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> and 
> commit a7b862f663d81858531dfccc0537bc9d8a2a4121
> Author: Chris Wedgwood <cw@f00f.org>
> Date:   Mon May 15 09:43:55 2006 -0700
>     [PATCH] VIA quirk fixup, additional PCI IDs    
> 
> BUT the latest stable and tested patch is the commit 09d6029f43ebbe7307854abdae204c25d711ff94
> PCI: VIA IRQ quirk behaviour change, which in my opinion that should go in.

Commit 09d6029f43ebbe7307854abdae204c25d711ff94 is what Alan wasn't 
happy with, and -mm contains Alan's solution...

> Thanks,
> Sérgio M.B.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

