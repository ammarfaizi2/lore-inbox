Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319380AbSIKXMj>; Wed, 11 Sep 2002 19:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319381AbSIKXMj>; Wed, 11 Sep 2002 19:12:39 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:13062 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S319380AbSIKXMh>; Wed, 11 Sep 2002 19:12:37 -0400
Message-Id: <200209112317.g8BNHLsG017117@pincoya.inf.utfsm.cl>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.33/drivers/input/keyboard/atkbd.c allow SETLEDS to fail 
In-Reply-To: Message from "Adam J. Richter" <adam@yggdrasil.com> 
   of "Tue, 10 Sep 2002 09:05:20 MST." <20020910090520.A731@adam.yggdrasil.com> 
Date: Wed, 11 Sep 2002 19:17:21 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> said:

[...]

> 	100 milliseconds, which normally only happens when the user
> hits CapsLock, NumLock or ScrollLock, which generally implies that a
> keyboard is present.  I suspect that you could change it to use mdelay
> instead of udelay, so that other processes could do useful work during
> the wait,

udelay() is busy wait, mdelay() is just calling udelay(1000) over and over.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
