Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752116AbWCOQOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbWCOQOv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 11:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbWCOQOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 11:14:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9747 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752116AbWCOQOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 11:14:50 -0500
Date: Wed, 15 Mar 2006 17:14:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: hostap@shmoo.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [2.6 patch] hostap_{pci,plx}.c: fix memory leaks
Message-ID: <20060315161449.GW13973@stusta.de>
References: <20060313222841.GQ13973@stusta.de> <20060315031625.GE9384@jm.kir.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315031625.GE9384@jm.kir.nu>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 07:16:25PM -0800, Jouni Malinen wrote:
> On Mon, Mar 13, 2006 at 11:28:41PM +0100, Adrian Bunk wrote:
> > This patch fixes two memotry leaks spotted by the Coverity checker.
> 
> Thanks. I'll make a bit different patch to resolve this and related PCI
> "leaks" in one change. I'm going through the Coverity reports for Host
> AP driver, so I'll include other fixes in a patch set, too.

Thanks (I assume you've seem Herbert's comment why my patch was wrong).

> Jouni Malinen                                            PGP id EFC895FA

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

