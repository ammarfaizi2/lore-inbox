Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136123AbREHDaf>; Mon, 7 May 2001 23:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136663AbREHDa0>; Mon, 7 May 2001 23:30:26 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:59397 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S136123AbREHDaW>;
	Mon, 7 May 2001 23:30:22 -0400
Message-Id: <200105080100.f4810tDa002446@sleipnir.valparaiso.cl>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: page_launder() bug 
In-Reply-To: Message from "David S. Miller" <davem@redhat.com> 
   of "Mon, 07 May 2001 15:44:37 MST." <15095.9557.998522.571971@pizda.ninka.net> 
Date: Mon, 07 May 2001 21:00:55 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> said:
> Linus Torvalds writes:
>  > The whole "dead_swap_page" optimization in the -ac tree is apparentrly
>  > completely bogus.  It caches a value that is not valid: you cannot
>  > reliably look at whether the page has buffers etc without holding the
>  > page locked. 

[...]

> Please show me how this is illegal.  Everyone comes to this conclusion
> when the first read the code, that I am doing something illegal, then
> when I explain what that dead_swap_page thing is doing and they read
> it a second time (how shocking! :-) they go "oh, I see".

Then it might be a better use of your time to place a comment in there
telling the gentle reader what is going on, and not tell them each time
they come asking/screaming that it is wrong. If even Linus gets confused by
it, it is mandatory IMVVHO
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
