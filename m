Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267347AbTALJrQ>; Sun, 12 Jan 2003 04:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbTALJrQ>; Sun, 12 Jan 2003 04:47:16 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:61642 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267347AbTALJrO>; Sun, 12 Jan 2003 04:47:14 -0500
Date: Sun, 12 Jan 2003 10:55:59 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: gerg@snapgear.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.56: undefined reference to `_ebss' from drivers/mtd/maps/uclinux.c
Message-ID: <20030112095559.GT21826@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

trying to compile 2.5.56 with CONFIG_MTD_UCLINUX fails on i386 with
  undefined reference to `_ebss'
at the final linking.

It seems _ebss is only defined on the architectures m68knommu and v850?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

