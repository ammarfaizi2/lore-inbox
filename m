Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288978AbSAFQIZ>; Sun, 6 Jan 2002 11:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288980AbSAFQIK>; Sun, 6 Jan 2002 11:08:10 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:41738 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S288978AbSAFQH6>;
	Sun, 6 Jan 2002 11:07:58 -0500
Message-Id: <200201061302.g06D2Uf9011204@sleipnir.valparaiso.cl>
To: Anton Blanchard <anton@samba.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove 8 bytes from struct page on 64bit archs 
In-Reply-To: Your message of "Sun, 06 Jan 2002 23:39:14 +1100."
             <20020106123913.GA5407@krispykreme> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sun, 06 Jan 2002 10:02:30 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> said:

[...]

> Here is a very simple patch (ppc64 only so far). For archs that have
> more than one memory zone, they should define the following:
> 
> #define ARCH_NR_ZONES 3
> #define GET_PAGE_ZONE(page)		(page)->zone
> #define SET_PAGE_ZONE(page, __zone)	(page)->zone = (__zone)

Better sprinkle in a few more ()'s...
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
