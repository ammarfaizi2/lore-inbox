Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317790AbSHGLJ1>; Wed, 7 Aug 2002 07:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317793AbSHGLJ1>; Wed, 7 Aug 2002 07:09:27 -0400
Received: from nuts.ninka.net ([216.101.162.246]:2688 "EHLO nuts.ninka.net")
	by vger.kernel.org with ESMTP id <S317790AbSHGLJ1>;
	Wed, 7 Aug 2002 07:09:27 -0400
Date: Wed, 7 Aug 2002 04:09:33 -0700
Message-Id: <200208071109.EAA05115@nuts.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: bunk@fs.tum.de
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-reply-to: <Pine.NEB.4.44.0208062302190.27501-100000@mimas.fachschaften.tu-muenchen.de>
	(message from Adrian Bunk on Tue, 6 Aug 2002 23:05:44 +0200 (CEST))
Subject: Re: Linux 2.4.20-pre1
References: <Pine.NEB.4.44.0208062302190.27501-100000@mimas.fachschaften.tu-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 6 Aug 2002 23:05:44 +0200 (CEST)
   From: Adrian Bunk <bunk@fs.tum.de>

   The changes to drivers/net/tg3.c in -pre1 broke the compilation:
 ...
   /home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/linux/if_vlan.h:186:
   warning: implicit declaration of function `netif_receive_skb'
   tg3.c: In function `tg3_poll':

Because Marcelo took the tg3 NAPI changes but not the NAPI
infrastructure. :-)

I'm hoping since he's decided to take the generic NAPI changes
this compile failure will go away in -pre2
