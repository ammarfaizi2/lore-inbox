Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVFKT3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVFKT3H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVFKT3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:29:07 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28422 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261793AbVFKT3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:29:02 -0400
Date: Sat, 11 Jun 2005 21:28:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unexport and static __mntput()
Message-ID: <20050611192859.GH3770@stusta.de>
References: <2cd57c90050609043125bd3e1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c90050609043125bd3e1f@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 07:31:41PM +0800, Coywolf Qi Hunt wrote:
> Hello,
> 
> I don't see any reasons that modules should call __mntput.
> And it's only called by mntput(). Or anyone knows any outer code depends on it?
> 
> Adrian, a patch unexport and static it?

Besides it being wrong (as Mike Waychison already explained), why can't 
you make patches yourself? It's not that I had any special position in 
kernel development...

> Coywolf Qi Hunt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

