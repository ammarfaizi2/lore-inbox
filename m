Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131562AbRDPQot>; Mon, 16 Apr 2001 12:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131590AbRDPQok>; Mon, 16 Apr 2001 12:44:40 -0400
Received: from feeder.cyberbills.com ([64.41.210.81]:61201 "EHLO
	sjc-smtp1.cyberbills.com") by vger.kernel.org with ESMTP
	id <S131587AbRDPQoe>; Mon, 16 Apr 2001 12:44:34 -0400
Date: Mon, 16 Apr 2001 09:44:27 -0700 (PDT)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac7
In-Reply-To: <E14pBgV-0000Vy-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31ksi3.0104160943360.20561-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2001, Alan Cox wrote:

> > gcc -D__KERNEL__ -I/tmp/build-kernel/usr/src/linux-2.4.3ac7/include
> -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
> -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS
> -include
> /tmp/build-kernel/usr/src/linux-2.4.3ac7/include/linux/modversions.h
> -c -o cycx_x25.o cycx_x25.c
> > cycx_x25.c: In function `new_if':
> > cycx_x25.c:364: structure has no member named `port'
>
> Fixed in my working tree. The Sangoma patch Linus merged accidentally
> backed out
> support for a competing product.

So we're waiting for ac8 to be out really soon or what?

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8808
Henderson, NV 89014

