Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbVKVQe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbVKVQe7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbVKVQe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:34:59 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:25751
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S964986AbVKVQe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:34:58 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] Small PCI core patch
Date: Tue, 22 Nov 2005 10:33:48 -0600
User-Agent: KMail/1.8
Cc: Denis Vlasenko <vda@ilport.com.ua>, Neil Brown <neilb@suse.de>,
       Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20051121225303.GA19212@kroah.com> <200511221007.12833.vda@ilport.com.ua> <20051122143055.GC24997@havoc.gtf.org>
In-Reply-To: <20051122143055.GC24997@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511221033.50351.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 November 2005 08:30, Jeff Garzik wrote:
> On Tue, Nov 22, 2005 at 10:07:12AM +0200, Denis Vlasenko wrote:
> > Historically hackers were not too good at raising funds.
> >
> > Maybe we should use stuff which we are good at? Forcedeth
> > is a nice precedent. 2d and especially 3d engines
> > may be significantly harder to reverse engineer,
> > but people can scale rather nicely, as kernel development shows. ;)
> >
> > Then write specs from gained knowledge and put it on a web page.
>
> Yes, IMO this is the only realistic path, without cooperation from
> ATI/NVIDIA.
>
> This is why I dislike the ATI r300 rev-eng effort:  I cannot find any
> "Chinese wall":  one team rev-engs the hardware and writes a doc.
> Another team writes the drivers from the docs.

If they're reverse engineering the hardware, why would you need a chinese 
wall?  Compaq was turning x86 assembly code into x86 assembly code and had to 
prove that the new x86 code didn't infringe the copyright on the old x86 
code.  They weren't turning port I/O and DMA logs into C code...

Rob
