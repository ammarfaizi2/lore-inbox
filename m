Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWCYTHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWCYTHA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 14:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWCYTHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 14:07:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16144 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932250AbWCYTHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 14:07:00 -0500
Date: Sat, 25 Mar 2006 20:06:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16 Regression:  vbetool:  Error: something went wrong performing real mode call
Message-ID: <20060325190658.GP4053@stusta.de>
References: <4422A340.2080104@rtr.ca> <4422A959.9030700@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4422A959.9030700@rtr.ca>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 08:57:45AM -0500, Mark Lord wrote:
> Mark Lord wrote:
> >As of 2.6.16, I am seeing this message when I do suspend-to-RAM
> >from a text window:
> >
> >Error: something went wrong performing real mode call
> >
> >I've narrowed it down to coming from "vbetool post"
> >on resume from RAM.
> 
> Mmm.. looking more closely, it's a vm86 (old) call failing,
> and I seem to be missing CONFIG_VM86 from my .config.
>...

It seems you are using CONFIG_EMBEDDED=y?

> Cheers

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

