Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbVITD3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbVITD3e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 23:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbVITD3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 23:29:34 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:16853 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964856AbVITD3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 23:29:33 -0400
Message-Id: <200509192316.j8JNFxY8030819@inti.inf.utfsm.cl>
To: Nikita Danilov <nikita@clusterfs.com>
cc: Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel 
In-Reply-To: Message from Nikita Danilov <nikita@clusterfs.com> 
   of "Sun, 18 Sep 2005 14:02:55 +0400." <17197.15183.235861.655720@gargle.gargle.HOWL> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 19 Sep 2005 19:15:59 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <nikita@clusterfs.com> wrote:
> Denis Vlasenko writes:
>  > On Friday 16 September 2005 20:05, Hans Reiser wrote:
>  > > All objections have now been addressed so far as I can discern.
>  > 
>  > Random observation:
>  > 
>  > You can declare functions even if you never use them.
>  > Thus here you can avoid using #if/#endif:
>  > 
>  > #if defined(REISER4_DEBUG) || defined(REISER4_DEBUG_MODIFY) || defined(REISER4_DEBUG_OUTPUT)
>  > int znode_is_loaded(const znode * node /* znode to query */ );
>  > #endif

> It's other way around: declaration is guarded by the preprocessor
> conditional so that nobody accidentally use znode_is_loaded() outside of
> the debugging mode.

Since when has a missing declaration prevented anyone calling a function in
C?!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
