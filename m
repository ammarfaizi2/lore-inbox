Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261496AbTCOTaS>; Sat, 15 Mar 2003 14:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261498AbTCOTaR>; Sat, 15 Mar 2003 14:30:17 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41170 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S261496AbTCOTaQ>;
	Sat, 15 Mar 2003 14:30:16 -0500
Message-Id: <200303151836.h2FIa6U4005547@eeyore.valparaiso.cl>
To: Oleg Drokin <green@namesys.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] init/do_mounts.c::rd_load_image() memleak 
In-Reply-To: Your message of "Fri, 14 Mar 2003 10:50:32 +0300."
             <20030314105032.A17568@namesys.com> 
Date: Sat, 15 Mar 2003 14:36:06 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@namesys.com> said:
> On Thu, Mar 13, 2003 at 10:03:08PM +0000, Russell King wrote:
> > > +	if (buf)
> > > +		kfree(buf);

> > kfree(NULL); is valid - you don't need this check.

> Almost every place I can think of does just this, so I do not see why this
> particular piece of code should be different.

Then the other code should be fixed. This is bloat.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
