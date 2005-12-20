Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVLUL7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVLUL7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 06:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVLUL7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 06:59:30 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:49080 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932381AbVLUL73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 06:59:29 -0500
Message-Id: <200512202208.jBKM87PK004603@laptop11.inf.utfsm.cl>
To: kernel-stuff@comcast.net (Parag Warudkar)
cc: David Lang <dlang@digitalinsight.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks 
In-Reply-To: Message from kernel-stuff@comcast.net (Parag Warudkar) 
   of "Tue, 20 Dec 2005 19:53:43 -0000." <122020051953.9002.43A861470004E9E70000232A220702095300009A9B9CD3040A029D0A05@comcast.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Tue, 20 Dec 2005 19:08:07 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 21 Dec 2005 08:56:15 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar <kernel-stuff@comcast.net> wrote:
> It's hard to believe all i386 people have a problem with 8K stacks. What
> you said may be a problem domain bound to a specific workload on i386
> with insane amounts of memory and fragmented LOWMEM. - These people can
> certainly use 4K stacks and no one is preventing that.

> But normal people with <=1Gb RAM and using i386 on desktop (I am sure
> there are many of them) may do OK with 8K stacks if they had a need to do
> so. (Like running ndiswrapper, or some other thing which requires bigger
> stacks for that matter.)

But those normal people are most of the users, running non-critical stuff,
and thus are /excellent/ guinea pigs for the "real world users" you
mentioned above ;-)

/me ducks and runs like all LKML is loose
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
