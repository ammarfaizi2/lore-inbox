Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTIPLvY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 07:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbTIPLvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 07:51:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42977 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261863AbTIPLvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 07:51:19 -0400
Date: Tue, 16 Sep 2003 13:51:14 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5-mm2: i4l coompile error
Message-ID: <20030916115113.GB17690@fs.tum.de>
References: <20030914234843.20cea5b3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914234843.20cea5b3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems group_leader-rework.patch broke the compilation of the old i4l?

<--  snip  -->

...
  CC      drivers/isdn/i4l/isdn_tty.o
...
drivers/isdn/i4l/isdn_tty.c: In function `modem_write_profile':
drivers/isdn/i4l/isdn_tty.c:1992: error: structure has no member named `pgrp'
make[3]: *** [drivers/isdn/i4l/isdn_tty.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

