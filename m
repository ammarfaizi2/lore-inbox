Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129157AbQKOFvu>; Wed, 15 Nov 2000 00:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKOFvj>; Wed, 15 Nov 2000 00:51:39 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:3339 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129212AbQKOFvd>;
	Wed, 15 Nov 2000 00:51:33 -0500
Message-Id: <200011150409.eAF49WP14784@sleipnir.valparaiso.cl>
To: Daniel Phillips <phillips@innominate.de>
cc: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit 
In-Reply-To: Message from Daniel Phillips <news-innominate.list.linux.kernel@innominate.de> 
   of "Tue, 14 Nov 2000 12:29:41 BST." <news2mail-3A112225.F29226B6@innominate.de> 
Date: Wed, 15 Nov 2000 01:09:32 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <news-innominate.list.linux.kernel@innominate.de> said:

[...]

> Heading in the right direction, but this is equivalent to:
> 
>   if (isalnum(*p) && *p != '-' && *p != '_') return -EINVAL;
> 
> which is faster, smaller and easier to read.

And wrong. ;-)
--
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
