Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSD3RhV>; Tue, 30 Apr 2002 13:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313205AbSD3RhV>; Tue, 30 Apr 2002 13:37:21 -0400
Received: from www.transvirtual.com ([206.14.214.140]:46853 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S313190AbSD3RhU>; Tue, 30 Apr 2002 13:37:20 -0400
Date: Tue, 30 Apr 2002 10:37:10 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: "Neal D. Becker" <nbecker@hns.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.11 error fbcon-cfg8.c
In-Reply-To: <x883cxd4ba6.fsf@rpppc1.md.hns.com>
Message-ID: <Pine.LNX.4.10.10204301036410.14139-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> gcc -D__KERNEL__ -I/usr/src/linux-2.5.11/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon    -DKBUILD_BASENAME=fbcon_cfb8  -DEXPORT_SYMTAB -c fbcon-cfb8.c
> fbcon-cfb8.c: In function `fbcon_cfb8_bmove':
> fbcon-cfb8.c:55: structure has no member named `screen_base'

Grab patch 

http://www.transvirtual.com/~jsimmons/fbdev_fixs.diff

