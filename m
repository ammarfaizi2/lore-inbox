Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967992AbWLEB3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967992AbWLEB3g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 20:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967994AbWLEB3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 20:29:36 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:1312 "EHLO
	pincoya.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967992AbWLEB3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 20:29:36 -0500
Message-Id: <200612050129.kB51TBaC027403@laptop13.inf.utfsm.cl>
To: art@usfltd.com
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: 2.6.19 git compile error - "current_is_keventd" [drivers/net/phy/libphy.ko] undefined 
In-Reply-To: Message from art@usfltd.com 
   of "Mon, 04 Dec 2006 18:07:31 MDT." <20061204180731.jeedbekf4f0g8ww0@69.222.0.225> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Mon, 04 Dec 2006 22:29:11 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Delayed for 00:04:06 by milter-greylist-3.0rc7 (pincoya.inf.utfsm.cl [200.1.19.3]); Mon, 04 Dec 2006 22:29:22 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

art@usfltd.com wrote:
> 2006/12/04/18:00 CST
> 
>   Building modules, stage 2.
> Kernel: arch/x86_64/boot/bzImage is ready  (#2)
>   MODPOST 1256 modules
> WARNING: "current_is_keventd" [drivers/net/phy/libphy.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2

Also i686, sparc64. At drivers/net/phy/phy.c:590 is the lone reference to
current_is_keventd in that directory.  Still present as of ff51a9...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

