Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVHXKyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVHXKyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 06:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVHXKyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 06:54:45 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11793 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750785AbVHXKyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 06:54:44 -0400
Date: Wed, 24 Aug 2005 12:54:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] #include <asm/irq.h> in interrupt.h
Message-ID: <20050824105442.GJ5603@stusta.de>
References: <20050824085750.GG5603@stusta.de> <20050824092250.GA26726@infradead.org> <20050824100857.GH5603@stusta.de> <1124880295.20120.44.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124880295.20120.44.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 10:44:55AM +0000, Thomas Gleixner wrote:
> On Wed, 2005-08-24 at 12:08 +0200, Adrian Bunk wrote:
> 
> > Looking at 2.6.13-rc6-mm2, the only architectures with own enable_irq() 
> > implementations are m68knommu and sparc.
> 
> You missed ARM.

Yes and no.

Yes, because you are right that I missed architectures.

No, because I was only looking at what would be required to 
unconditionally offer the enable_irq() prototyp in interrupt.h .

> tglx

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

