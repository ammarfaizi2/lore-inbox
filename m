Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313299AbSD3Mck>; Tue, 30 Apr 2002 08:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313300AbSD3Mcj>; Tue, 30 Apr 2002 08:32:39 -0400
Received: from excore1.hns.com ([139.85.52.104]:57785 "EHLO excore1.hns.com")
	by vger.kernel.org with ESMTP id <S313299AbSD3Mci>;
	Tue, 30 Apr 2002 08:32:38 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.5.11 error fbcon-cfg8.c
From: nbecker@hns.com (Neal D. Becker)
Date: 30 Apr 2002 08:32:33 -0400
Message-ID: <x883cxd4ba6.fsf@rpppc1.md.hns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux-2.5.11/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon    -DKBUILD_BASENAME=fbcon_cfb8  -DEXPORT_SYMTAB -c fbcon-cfb8.c
fbcon-cfb8.c: In function `fbcon_cfb8_bmove':
fbcon-cfb8.c:55: structure has no member named `screen_base'
[...]
