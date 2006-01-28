Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWA1GEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWA1GEm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 01:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWA1GEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 01:04:42 -0500
Received: from cantor.suse.de ([195.135.220.2]:24780 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751128AbWA1GEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 01:04:42 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 09/12] Mask off GFP flags before swiotlb_alloc_coherent
Date: Sat, 28 Jan 2006 07:04:13 +0100
User-Agent: KMail/1.8.2
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       jmforbes@linuxtx.org, zwane@arm.linux.org.uk, tytso@mit.edu,
       rdunlap@xenotime.net, davej@redhat.com, chuckw@quantumlinux.com,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk
References: <20060128020629.908825000@press.kroah.org> <200601280333.25026.ak@suse.de> <20060127194954.0c9efcd6.akpm@osdl.org>
In-Reply-To: <20060127194954.0c9efcd6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601280704.15293.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 January 2006 04:49, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> >  On Saturday 28 January 2006 03:21, Greg KH wrote:
> >  > 2.6.15.2 -stable review patch.  If anyone has any objections, please let 
> >  > us know.
> > 
> >  That patch isn't in mainline yet and shouldn't be merged to stable before
> >  that happens.
> 
> But this patch will never go into mainline - pci-gart.c was radically
> altered in 2.6.16-rc1.

It has an direct equivalent in the mainline version. It's 
ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/swiotlb-dma32

-Andi

P.S.: I already have quite a lot of pure bug fixes for x86-64 (+ 1 late 
but important feature). There will be a relatively big late
x86-64 syncup for 2.6.16 soon.
