Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316593AbSGBBhu>; Mon, 1 Jul 2002 21:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316569AbSGBBht>; Mon, 1 Jul 2002 21:37:49 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:55558 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S316593AbSGBBhs>;
	Mon, 1 Jul 2002 21:37:48 -0400
Message-Id: <200207020139.g621d532021746@sleipnir.valparaiso.cl>
To: Pavel Machek <pavel@ucw.cz>
cc: "David S. Miller" <davem@redhat.com>, alex@PolesApart.wox.org,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131 
In-reply-to: Your message of "Mon, 01 Jul 2002 04:18:55 +0200."
             <20020701021854.GA829@elf.ucw.cz> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Mon, 01 Jul 2002 21:39:05 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> said:

[...]

> Actually, then you should taint kernel for starting X, too... Anything
> running with root priviledges can scribble over memory.

Come on, a wild pointer in a random program running as root won't ever
bring the kernel down, as a wild pointer in a module certainly can/will.
--
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
