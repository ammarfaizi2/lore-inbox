Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVDTXcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVDTXcx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 19:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVDTXcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 19:32:53 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26374 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261834AbVDTXcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 19:32:51 -0400
Date: Thu, 21 Apr 2005 01:32:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rename "---help---" to "help" in Kconfig files
Message-ID: <20050420233246.GT5489@stusta.de>
References: <Pine.LNX.4.62.0504202306350.2071@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504202306350.2071@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 12:06:11AM +0200, Jesper Juhl wrote:
>...
> Why does it do this? :  There are two reasons for doing this;
> 1) Consistency. out of ~4000 help entries in 134 Kconfig files, 747 of 
> those entries use "---help---" as the keyword, the rest use just "help". 
> So the users of "---help---" are clearly a minority and by renaming them 
> we make things consistent. - I hate inconsistency. :-)
> 2) By not using two different "keywords" I assume it will be posible to 
> speed up kbuilds handling of Kconfig files slightly. That goal is not 
> accomplished by this patch, but this patch is a prerequisite for making 
> that change later.
>...

I'd be surprised if the second reason had a measurable effect, but I 
like this patch for the first reason.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

