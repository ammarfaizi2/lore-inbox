Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269589AbRHHWZm>; Wed, 8 Aug 2001 18:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269593AbRHHWZc>; Wed, 8 Aug 2001 18:25:32 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:12295 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S269589AbRHHWZT>; Wed, 8 Aug 2001 18:25:19 -0400
Message-Id: <200108082224.f78MOvuB015808@pincoya.inf.utfsm.cl>
To: Riley Williams <rhw@MemAlpha.CX>, Andrzej Krzysztofowicz <ankry@pg.gda.pl>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work? 
In-Reply-To: Message from Riley Williams <rhw@MemAlpha.CX> 
   of "Wed, 08 Aug 2001 22:31:02 +0100." <Pine.LNX.4.33.0108082211410.12565-100000@infradead.org> 
Date: Wed, 08 Aug 2001 18:24:57 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams <rhw@MemAlpha.CX> said:

[...]

> According to Alan Cox, it's only the ix86 architecture where the MAC
> is per interface; on all other architectures, it's one MAC per system
> that is shared by all the ethernet interfaces. As a result, there is
> no guarantee that they are identical, or even similar.

On Sun all NICs of a machine by default share the same MAC (and you can
change them individually at will, BTW). Other machines I've come across
aren't this way. But there are several NICs around (even seen them on PCs,
don't remember which ones, sorry) where you can change the MAC at will, and
the change sticks IIRC.

If you look at how Ethernet works, it is clear that the MAC has to be
unique on its network segment only, making it globally unique is simple,
but way overkill.
