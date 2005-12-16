Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVLPP6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVLPP6Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVLPP6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:58:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25363 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932332AbVLPP6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:58:23 -0500
Date: Fri, 16 Dec 2005 16:58:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Diego Calleja <diegocg@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051216155824.GE23349@stusta.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051216163503.289d491e.diegocg@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 04:35:03PM +0100, Diego Calleja wrote:
> El Fri, 16 Dec 2005 15:04:25 +0100,
> Adrian Bunk <bunk@stusta.de> escribió:
> 
> > My count of bug reports for problems with 4k stacks after Neil's patch
> > went into -mm is still at 0.
> > 
> > Either there are no problems left or noone pays attention to them since 
> > disabling 4k stacks "fixed" the problem.
> > 
> > In both cases there's no reason against applying my patch.
> 
> I know, but there's too much resistance to the "pure" 4kb patch. The
> 8 KB patch does the same thing (enables 4kb stacks)  and at the same
> time the 8kb groupies can't flamewar you for it, it covers akpm's

I have no problems with people flaming me.

I had problems if people would actually find technical reasons where my 
patch breaks in-kernel code.  ;-)

> concerns, it puts some pressure on the ndiswrapper guys and leaves
> time for the broadcom driver developers to finish, merge and push
> to the distributions their driver. The 8kb config option can be
> removed in the future when we're sure that it's 100% safe (neil
> brown's patch isn''t a good sign). It makes every happy IMO ;)

Neil's patch fixes the last known poroblems.

My count of bug reports for problems with 4k stacks after Neil's patch
went into -mm is still at 0.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

