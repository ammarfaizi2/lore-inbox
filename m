Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751693AbWCNBGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbWCNBGY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbWCNBGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:06:24 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38672 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751493AbWCNBGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:06:22 -0500
Date: Tue, 14 Mar 2006 02:06:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Parag Warudkar <kernel-stuff@comcast.net>,
       Miguel Blanco <mblancom@gmail.com>,
       Mauro Tassinari <mtassinari@cmanet.it>, perex@suse.cz,
       alsa-devel@alsa-project.org
Subject: Re: 2.6.16-rc6: known regressions
Message-ID: <20060314010621.GR13973@stusta.de>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <20060313200544.GG13973@stusta.de> <20060313144244.266d96ef.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313144244.266d96ef.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 02:42:44PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > This email lists some known regressions in 2.6.16-rc6 compared to 2.6.15.
> >
> 
> We've also left a trail of wrecked machines behind us from earlier kernels.
>...
> Post-2.6.15:
>   From: Parag Warudkar <kernel-stuff@comcast.net>
>   Subject: Re: ALSA HDA Intel stoped to work in 2.6.16-*

Is this the interrupt problem from the "ALSA can't cherry-pick" 
category?

>...
> XFS-related oopses:
>   http://bugzilla.kernel.org/show_bug.cgi?id=6180

This was in my list.

>...
> Post-2.6.14:
>   From: "Miguel Blanco" <mblancom@gmail.com>
>   Subject: problem mounting a jffs2 filesystem
> 
>   (We might have fixed this?)

This was fixed with commit e96fb230cc97760e448327c0de612cfba94ca7bf.

>...
> Post-2.6.16-rc1:
>   From: "Mauro Tassinari" <mtassinari@cmanet.it>
>   Subject: Re: 2.6.16-rc3: more regressions
> 
>   (Radeon makes Xorg hang)
>...

This was fixed with commit 75c0141ca2fdae7c332d8f17412fbe0939dd005f.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

