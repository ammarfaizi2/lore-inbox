Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268206AbRHOXCu>; Wed, 15 Aug 2001 19:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268199AbRHOXCl>; Wed, 15 Aug 2001 19:02:41 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:62983 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S268149AbRHOXCd>;
	Wed, 15 Aug 2001 19:02:33 -0400
Message-Id: <200108152214.f7FMEBHg007574@sleipnir.valparaiso.cl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, mag@fbab.net,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.8 Resource leaks + limits 
In-Reply-To: Message from Linus Torvalds <torvalds@transmeta.com> 
   of "Wed, 15 Aug 2001 09:53:09 MST." <Pine.LNX.4.33.0108150952001.2220-100000@penguin.transmeta.com> 
Date: Wed, 15 Aug 2001 18:14:11 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> said:

[...]

> No, I think the answer there is to do all the same things for "struct
> group" as we do for user.
> 
> Yes, it would mean that the primary group is _really_ primary, but from a
> system management standpoint that's probably preferable (ie you can give
> group read-write access to a person without giving group "resource" access
> to him)

No good. Some setups (e.g. Red Hat) have a group for each user.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
