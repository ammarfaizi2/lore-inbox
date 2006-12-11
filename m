Return-Path: <linux-kernel-owner+w=401wt.eu-S1762884AbWLKMsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762884AbWLKMsO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 07:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762881AbWLKMsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 07:48:14 -0500
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:52235 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1762884AbWLKMsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 07:48:13 -0500
X-AntiVirus: PTMail-AV 0.3-0.88.6
Subject: Re: RFC: PCI quirks update for 2.6.16
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Daniel Drake <dsd@gentoo.org>, Daniel Ritz <daniel.ritz@gmx.ch>,
       Jean Delvare <khali@linux-fr.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20061211124148.GJ10351@stusta.de>
References: <20061207132430.GF8963@stusta.de> <45782774.8060002@gentoo.org>
	 <1165723779.334.3.camel@localhost.localdomain>
	 <20061210160053.GD10351@stusta.de> <1165801368.2987.20.camel@monteirov>
	 <20061211124148.GJ10351@stusta.de>
Content-Type: text/plain; charset=utf-8
Date: Mon, 11 Dec 2006 12:48:10 +0000
Message-Id: <1165841290.5848.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 13:41 +0100, Adrian Bunk wrote:
> On Mon, Dec 11, 2006 at 01:42:48AM +0000, Sergio Monteiro Basto wrote:
> > On Sun, 2006-12-10 at 17:00 +0100, Adrian Bunk wrote:
> > > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
> > > quirk_via_irq);
> > 
> > This is back to state of kernel 2.6.16 final (without .x)
> > 
> > In kernel 2.6.17 final we got
> > (http://lkml.org/lkml/2006/4/19/16)
> > commit 75cf7456dd87335f574dcd53c4ae616a2ad71a11 
> > Author: Chris Wedgwood <cw@f00f.org>
> > Date:   Tue Apr 18 23:57:09 2006 -0700 
> >     Signed-off-by: Chris Wedgwood <cw@f00f.org>
> >     Acked-by: Jeff Garzik <jeff@garzik.org>
> >     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > and 
> > commit a7b862f663d81858531dfccc0537bc9d8a2a4121
> > Author: Chris Wedgwood <cw@f00f.org>
> > Date:   Mon May 15 09:43:55 2006 -0700
> >     [PATCH] VIA quirk fixup, additional PCI IDs    
> > 
> > BUT the latest stable and tested patch is the commit 09d6029f43ebbe7307854abdae204c25d711ff94
> > PCI: VIA IRQ quirk behaviour change, which in my opinion that should go in.
> 
> Commit 09d6029f43ebbe7307854abdae204c25d711ff94 is what Alan wasn't 
> happy with, and -mm contains Alan's solution...

No, Alan's solution was a post solution , which still on -mm, I think .

Thanks,
> 
> > Thanks,
> > Sérgio M.B.
> 
> cu
> Adrian
> 

