Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWHUTWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWHUTWS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 15:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWHUTWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 15:22:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7181 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750857AbWHUTWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 15:22:16 -0400
Date: Mon, 21 Aug 2006 21:22:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/wd33c93.c: cleanups
Message-ID: <20060821192215.GL11651@stusta.de>
References: <20060821104357.GH11651@stusta.de> <20060821105344.GA28759@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821105344.GA28759@infradead.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 11:53:44AM +0100, Christoph Hellwig wrote:
> On Mon, Aug 21, 2006 at 12:43:57PM +0200, Adrian Bunk wrote:
> > This patch contains the following cleanups:
> > - #include <linux/irq.h> for getting the prototypes of
> >   {dis,en}able_irq()
> 
> nothing outside of arch code must ever include <linux/irq.h>

Why?
It sounds rather strange that non-arch code should use asm headers.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

