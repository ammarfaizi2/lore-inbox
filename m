Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTFCSZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 14:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbTFCSZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 14:25:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15315 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261365AbTFCSZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 14:25:12 -0400
Date: Tue, 3 Jun 2003 20:38:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.21rc6-ac2: ac97_codec.c doesn't compile
Message-ID: <20030603183833.GO27168@fs.tum.de>
References: <200306031035.h53AZRV16959@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306031035.h53AZRV16959@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

...
gcc -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.21-rc6-ac2-full/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix 
include -DKBUILD_BASENAME=ac97_codec  -c -o ac97_codec.o ac97_codec.c
ac97_codec.c: In function `ac97_alloc_codec':
ac97_codec.c:736: structure has no member named `lock'
make[3]: *** [ac97_codec.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.21-rc6-ac2-full/drivers/sound'

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

