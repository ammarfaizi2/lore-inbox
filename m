Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVL2QkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVL2QkF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVL2QkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:40:05 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:29080 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750808AbVL2QkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:40:04 -0500
Message-Id: <200512291639.jBTGdfLZ015516@laptop11.inf.utfsm.cl>
To: Brian Gerst <bgerst@didntduck.org>
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Split out screen_info from tty.h 
In-Reply-To: Message from Brian Gerst <bgerst@didntduck.org> 
   of "Wed, 28 Dec 2005 16:50:12 CDT." <43B30894.20904@didntduck.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Thu, 29 Dec 2005 13:39:41 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 29 Dec 2005 13:39:44 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <bgerst@didntduck.org> wrote:
> This makes it possible for boot code to use screen_info without dragging in
> all of tty.h.

Why is that a problem? Introducing yet another .h that developers have to
remember and use appropiately has a cost, so... and I see no changes except
for different #include lines in your patch.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
