Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267133AbTAURZn>; Tue, 21 Jan 2003 12:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbTAURZn>; Tue, 21 Jan 2003 12:25:43 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:3808 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267133AbTAURZm>; Tue, 21 Jan 2003 12:25:42 -0500
Message-Id: <200301211701.h0LH1KIQ002083@eeyore.valparaiso.cl>
To: Bill Davidsen <davidsen@tmr.com>
cc: "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       brand@eeyore.valparaiso.cl
Subject: Re: Patch?: linux-2.5.59/sound/soundcore.c referenced non-existant errno variable 
In-Reply-To: Your message of "Tue, 21 Jan 2003 11:48:56 EST."
             <Pine.LNX.3.96.1030121111236.30858A-100000@gatekeeper.tmr.com> 
Date: Tue, 21 Jan 2003 18:01:20 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> said:

[...]

> I have not looked at the code this generates, it's a comment on human
> readability rather than an actual implementation, and I'm sure someone
> will argue that the first failure should just be a return if there's
> nothing else which needs to be done. On the other hand the return inline
> would be more bytes, so someone else can argue against. 

Older gccs used to generate horrible code for several "return foo;" in the
function, dunno how it is today.

Besides, today there might be nothing else to do, but that can change. In
that case you'd better have all exits together.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
