Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262297AbSI3Oen>; Mon, 30 Sep 2002 10:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbSI3Oen>; Mon, 30 Sep 2002 10:34:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41926 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262297AbSI3Oem>; Mon, 30 Sep 2002 10:34:42 -0400
Date: Mon, 30 Sep 2002 16:40:00 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: 2.5.29: CONFIG_BLK_DEV_{IDEPCI,GENERIC} configure options look
 strange
Message-ID: <Pine.NEB.4.44.0209301637420.12605-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

since your "Cleanup Config.in, and remove unused options" patch the
CONFIG_BLK_DEV_{IDEPCI,GENERIC} configure options look very strange (this
is "make oldconfig"):

<--  snip  -->

  Generic PCI IDE chipset support (CONFIG_BLK_DEV_IDEPCI) [Y/n/?]
    Generic PCI IDE Chipset Support (CONFIG_BLK_DEV_GENERIC) [N/y/?] (NEW)

<--  snip  -->

Could you fix this?

TIA
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



