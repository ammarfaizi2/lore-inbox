Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWA2XSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWA2XSy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 18:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWA2XSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 18:18:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18437 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932070AbWA2XSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 18:18:54 -0500
Date: Mon, 30 Jan 2006 00:18:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Christoph Hellwig <hch@infradead.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060129231853.GZ3777@stusta.de>
References: <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu> <1138466271.8770.77.camel@lade.trondhjem.org> <20060128165732.GA8633@hardeman.nu> <1138504829.8770.125.camel@lade.trondhjem.org> <20060129113320.GA21386@hardeman.nu> <20060129122901.GX3777@stusta.de> <1138540148.3002.9.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138540148.3002.9.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 02:09:08PM +0100, Arjan van de Ven wrote:
> 
> > 
> > You are taking the wrong approach.
> > 
> > The _only_ question that matters is:
> > Why is it technically impossible to do the same in userspace?
> > 
> > If it's technically possible to do the same in userspace, it must not be 
> > done in the kernel.
> 
> 
> that is not a reasonable statement because...
> 1) you can do all of tcp/ip in userspace just fine
> 2) you can do the NFS server in userspace
> 3) ...
> 4) ...
> 
> there are reasons why things that can be done in userspace sometimes
> still make sense to do in kernel space, performance could be one of
> those reasons, being unreasonably complex in userspace is another.

Agreed, my sentence was too general.

> Identity management to some degree belongs in the kernel, simply because
> identity *enforcing* is in the kernel. Some things related to security
> need to be in the kernel at least partially just to avoid a LOT of hairy
> issues and never ending series of security holes due to the exceptional
> complexity you get.

OK, this sounds reasonable in the cases where the enforcing is actually 
in the kernel (but not in the backup daemon example from this thread).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

