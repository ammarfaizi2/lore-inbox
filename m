Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUCKUbI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUCKU14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:27:56 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:59868 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261718AbUCKU1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:27:32 -0500
Message-Id: <200403112027.i2BKR3RX005451@eeyore.valparaiso.cl>
To: pg smith <pete@linuxbox.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LKM rootkits in 2.6.x 
In-Reply-To: Your message of "Thu, 11 Mar 2004 11:26:23 -0800."
             <Pine.LNX.4.44.0403111124020.27770-100000@linuxbox.co.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Thu, 11 Mar 2004 17:27:03 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pg smith <pete@linuxbox.co.uk> said:
> Any thoughts on the future of LKM rootkits in the 2.6 kernel branch ? In
> the last few years I've become quite interested in them (from a defensive
> point of view), but with the 2.6 kernel no longer exporting the syscall
> table, intercepting system calls would appear to be a non-starter now. In
> a perverse sort of way, i'm actually rather dissapointed: all that
> learning gone to waste.

If you get to load a module, you are in-kernel. Once there, you can either
use what you know are the offsets for $distro-$version-$arch kernel and be
in business as usual, or fool around on your own. Harder than before, yes.
Impossible, by no means.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
