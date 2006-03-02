Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752000AbWCBVyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbWCBVyQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbWCBVyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:54:16 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59878 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1752000AbWCBVyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:54:15 -0500
Date: Thu, 2 Mar 2006 22:53:30 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, dtor_core@ameritech.net,
       jgeorgas@rogers.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
In-Reply-To: <20060302214055.GH9295@stusta.de>
Message-ID: <Pine.LNX.4.61.0603022251270.13101@yvahk01.tjqt.qr>
References: <20060301175852.GA4708@stusta.de> <E1FEcfG-000486-00@gondolin.me.apana.org.au>
 <20060302173840.GB9295@stusta.de> <9a8748490603021228k7ad1fb5gd931d9778307ca58@mail.gmail.com>
 <20060302203245.GD9295@stusta.de> <9a8748490603021240t31f58ea4ycafae4ee8a12095c@mail.gmail.com>
 <20060302214055.GH9295@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Can anyone bring real life examples for this pretended harm?
>
>All examples I have heard until now fall under one of the following:
>- CONFIG_MODULES=n wouldn't be worse
>- if you want your kernel to fit on a floppy, CONFIG_UNIX shouldn't be 
>  the thing making the difference between the kernel fitting on the
>  floppy and the kernel not fitting on the floppy
>
Well, not directly topic'ed to CONFIG_UNIX, but if the IPv4 stack was modular
(like IPv6), we'd probably gain some 100 KB and would not have to worry about
CONFIG_UNIX for a while.


Jan Engelhardt
-- 
