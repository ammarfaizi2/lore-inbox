Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVBYVnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVBYVnm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 16:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVBYVnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 16:43:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58377 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261859AbVBYVna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 16:43:30 -0500
Date: Fri, 25 Feb 2005 22:43:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport do_settimeofday
Message-ID: <20050225214326.GE3311@stusta.de>
References: <20050224233742.GR8651@stusta.de> <20050224212448.367af4be.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224212448.367af4be.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 09:24:48PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > 
> >  I haven't found any possible modular usage of do_settimeofday in the 
> >  kernel.
> 
> Please,
> 
> - Add deprecated_if_module
>...

What's the correct header file for __deprecated_if_module ?
module.h ?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

