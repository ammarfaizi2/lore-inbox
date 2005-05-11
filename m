Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVEKW7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVEKW7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 18:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVEKW54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 18:57:56 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61188 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261309AbVEKW47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 18:56:59 -0400
Date: Thu, 12 May 2005 00:56:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Andrew Morton <akpm@osdl.org>,
       davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace cleanup)
Message-ID: <20050511225657.GM6884@stusta.de>
References: <20050510161657.3afb21ff.akpm@osdl.org> <20050510.161907.116353193.davem@davemloft.net> <20050510170246.5be58840.akpm@osdl.org> <20050510.170946.10291902.davem@davemloft.net> <Pine.LNX.4.62.0505110217350.2386@dragon.hyggekrogen.localhost> <20050510172913.2d47a4d4.akpm@osdl.org> <Pine.LNX.4.62.0505110236520.2386@dragon.hyggekrogen.localhost> <4281E78B.2030103@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4281E78B.2030103@grupopie.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 12:07:55PM +0100, Paulo Marques wrote:
> Jesper Juhl wrote:
> >On Tue, 10 May 2005, Andrew Morton wrote:
> >
> >>Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >>
> >>>[...]
> >>>Ohh, and I'd be submitting all the patches to you Andrew, not individual 
> >>>maintainers/authors..
> >>
> >>That should be OK - you can test that the .o files have the same `size'
> >>output before-and-after.
> >>
> >>[...]
> >
> >Ok, will do.
> 
> Just a small sugestion: do a sha (or md5sum, or whatever hash function 
> you prefer) to vmlinux before and after applying the patches.
> 
> If all is well, it shouldn't change (since this is just whitespace 
> cleanup), and it is a little more robust than just checking the size.


That's wrong.

vmlinux contains the date of the compilation.


> Paulo Marques - www.grupopie.com


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

