Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbUCCSrW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 13:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbUCCSrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 13:47:22 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32490 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262527AbUCCSrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 13:47:05 -0500
Date: Wed, 3 Mar 2004 19:46:57 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.4-rc1-mm2
Message-ID: <20040303184656.GE24510@fs.tum.de>
References: <20040302201536.52c4e467.akpm@osdl.org> <20040303113229.GA4921@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303113229.GA4921@werewolf.able.es>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 12:32:29PM +0100, J.A. Magallon wrote:
> 
> On 03.03, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm2/
> > 
> > - More VM tweaks and tuneups
> > 
> > - Added a 4k kernel- and irq-stack option for x86
> > 
> > - Largeish NFS client update
> > 
> 
> I can't deselect the crypto API, with the same .config as previous kernels.
> Some core driver now depends on it ?

Looking at the diff, the following options now select CRYPTO:
- Provide NFSv4 client support (EXPERIMENTAL)
- Secure RPC: Kerberos V mechanism (EXPERIMENTAL)

> TIA

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

