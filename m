Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbVKVQiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbVKVQiv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbVKVQiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:38:50 -0500
Received: from havoc.gtf.org ([69.61.125.42]:61830 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964990AbVKVQit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:38:49 -0500
Date: Tue, 22 Nov 2005 11:38:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Rob Landley <rob@landley.net>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Neil Brown <neilb@suse.de>,
       Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
Message-ID: <20051122163848.GC32684@havoc.gtf.org>
References: <20051121225303.GA19212@kroah.com> <200511221007.12833.vda@ilport.com.ua> <20051122143055.GC24997@havoc.gtf.org> <200511221033.50351.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511221033.50351.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 10:33:48AM -0600, Rob Landley wrote:
> On Tuesday 22 November 2005 08:30, Jeff Garzik wrote:
> > On Tue, Nov 22, 2005 at 10:07:12AM +0200, Denis Vlasenko wrote:
> > > Historically hackers were not too good at raising funds.
> > >
> > > Maybe we should use stuff which we are good at? Forcedeth
> > > is a nice precedent. 2d and especially 3d engines
> > > may be significantly harder to reverse engineer,
> > > but people can scale rather nicely, as kernel development shows. ;)
> > >
> > > Then write specs from gained knowledge and put it on a web page.
> >
> > Yes, IMO this is the only realistic path, without cooperation from
> > ATI/NVIDIA.
> >
> > This is why I dislike the ATI r300 rev-eng effort:  I cannot find any
> > "Chinese wall":  one team rev-engs the hardware and writes a doc.
> > Another team writes the drivers from the docs.
> 
> If they're reverse engineering the hardware, why would you need a chinese 
> wall?  Compaq was turning x86 assembly code into x86 assembly code and had to 
> prove that the new x86 code didn't infringe the copyright on the old x86 
> code.  They weren't turning port I/O and DMA logs into C code...

Chinese wall is far more secure legally.

Linux doesn't need more headaches from open legal questions.

It worked for forcedeth, Broadcom wireless, and several other
projects...  it results in a better driver, too.

	Jeff



