Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264046AbTFCT4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 15:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264047AbTFCT4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 15:56:42 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:17011 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264046AbTFCT4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 15:56:41 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200306032009.h53K98318053@devserv.devel.redhat.com>
Subject: Re: 2.4.21rc6-ac2: ac97_codec.c doesn't compile
To: bunk@fs.tum.de (Adrian Bunk)
Date: Tue, 3 Jun 2003 16:09:08 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20030603183833.GO27168@fs.tum.de> from "Adrian Bunk" at Meh 03, 2003 08:38:34 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -I/home/bunk/linux/kernel-2.4/linux-2.4.21-rc6-ac2-full/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix 
> include -DKBUILD_BASENAME=ac97_codec  -c -o ac97_codec.o ac97_codec.c
> ac97_codec.c: In function `ac97_alloc_codec':
> ac97_codec.c:736: structure has no member named `lock'
> make[3]: *** [ac97_codec.o] Error 1
> make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.21-rc6-ac2-full/drivers/sound'
> 
> <--  snip  -->

I only built it uniprocessor so I missed that one
