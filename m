Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVBQD4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVBQD4O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 22:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbVBQD4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 22:56:13 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:26567 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262205AbVBQD4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 22:56:06 -0500
Message-Id: <200502170348.j1H3mVpV008827@laptop11.inf.utfsm.cl>
To: Andrew Morton <akpm@osdl.org>
cc: Parag Warudkar <kernel-stuff@comcast.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: -rc3 leaking NOT BIO [Was: Memory leak in 2.6.11-rc1?] 
In-Reply-To: Message from Andrew Morton <akpm@osdl.org> 
   of "Wed, 16 Feb 2005 15:51:42 -0800." <20050216155142.6840497f.akpm@osdl.org> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 17)
Date: Thu, 17 Feb 2005 00:48:30 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> said:
> Parag Warudkar <kernel-stuff@comcast.net> wrote:

[...]

> > Is there a reason X86_64 doesnt have CONFIG_FRAME_POINTER anywhere in 
> > the .config?

> No good reason, I suspect.

Does x86_64 use up a (freeable) register for the frame pointer or not?
I.e., does -fomit-frame-pointer have any effect on the generated code?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
