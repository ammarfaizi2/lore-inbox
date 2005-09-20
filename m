Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbVITPgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbVITPgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbVITPgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:36:50 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:59269 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S965046AbVITPgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:36:49 -0400
Message-Id: <200509201536.j8KFa6wn011651@laptop11.inf.utfsm.cl>
To: Nikita Danilov <nikita@clusterfs.com>
cc: stephen.pollei@gmail.com, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel 
In-Reply-To: Message from Nikita Danilov <nikita@clusterfs.com> 
   of "Tue, 20 Sep 2005 13:30:46 +0400." <17199.54982.637650.772991@gargle.gargle.HOWL> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 20 Sep 2005 11:36:06 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 20 Sep 2005 11:36:06 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <nikita@clusterfs.com> wrote:
> Stephen Pollei writes:
>  > On 9/19/05, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
>  > > Nikita Danilov <nikita@clusterfs.com> wrote:
>  > > > It's other way around: declaration is guarded by the preprocessor
>  > > > conditional so that nobody accidentally use znode_is_loaded()
>  > > > outside of the debugging mode.

>  > > Since when has a missing declaration prevented anyone calling a
>  > > function in C?!

> It issues a warning, which is enough, given that reiser4 code was
> warning-free most of the time.

It is supposed to go into the kernel, which is not exactly warning-free.
Besides, you don't know what idiotic new warnings the gcc people might
dream up the next round, so just relying on no warnings is extremely
unwise.

As was said before: It it is /really/ wrong, arrange for it not to compile
or not to link. If it isn't, well... then it wasn't that wrong anyway.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

