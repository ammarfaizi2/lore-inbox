Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264551AbUD2Nv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbUD2Nv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 09:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbUD2Nv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 09:51:59 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:13203 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264542AbUD2Nv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 09:51:57 -0400
Message-Id: <200404291351.i3TDpoev003956@eeyore.valparaiso.cl>
To: brettspamacct@fastclick.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell 
In-Reply-To: Your message of "Wed, 28 Apr 2004 17:04:14 MST."
             <4090467E.4070709@fastclick.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Thu, 29 Apr 2004 09:51:48 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brett E." <brettspamacct@fastclick.com> said:

[...]

> I created a hack which allocates memory causing cache to go down, then 
> exits, freeing up the malloc'ed memory. This brings free memory up by 
> 400 megs and brings the cache down to close to 0, of course the cache 
> grows right afterwards. It would be nice to cap the cache datastructures 
> in the kernel but I've been posting about this since September to no 
> avail so my expectations are pretty low.

Because it is complete nonsense. Keeping stuff around in RAM in case it
is needed again, as long as RAM is not needed for anything else, is a mayor
win. That is what cache is.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
