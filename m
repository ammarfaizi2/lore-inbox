Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWEVTOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWEVTOX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWEVTOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:14:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31502 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751088AbWEVTOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:14:23 -0400
Date: Mon, 22 May 2006 21:14:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Zachary Amsden <zach@vmware.com>, jakub@redhat.com,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, kraxel@suse.de
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range patch
Message-ID: <20060522191421.GC9847@stusta.de>
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain> <20060519174303.5fd17d12.akpm@osdl.org> <20060522162949.GG30682@devserv.devel.redhat.com> <4471EA60.8080607@vmware.com> <20060522101454.52551222.akpm@osdl.org> <20060522172710.GA22823@elte.hu> <Pine.LNX.4.64.0605221045140.3697@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605221045140.3697@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 10:46:33AM -0700, Linus Torvalds wrote:
>...
> > is it really a big problem to add "vdso=0" to the long list of 
> > requirements you need to run a 2.6 kernel on an old distribution (or to 
> > disable CONFIG_VDSO)? FC1 wasnt even 2.6-ready, it used a 2.4 kernel!
> 
> Backwards compatibility is absolutely paramount. Much more important than 
> just about anything else.

Unless I'm misunderstanding this issue, no official glibc release was 
ever affected which makes the probability of other people being affected 
pretty small.

And this issue is about backwards compatibility only insofar, that it 
works around a bug in some ancient cvs versions of glibc.

Is it a new policy that the kernel mustn't break any buggy userspace 
code?

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

