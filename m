Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWAKV2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWAKV2g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWAKV2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:28:36 -0500
Received: from orion2.pixelized.ch ([195.190.190.13]:47235 "EHLO
	mail.pixelized.ch") by vger.kernel.org with ESMTP id S1750786AbWAKV2f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:28:35 -0500
Message-ID: <43C57875.3080404@debian.org>
Date: Wed, 11 Jan 2006 22:28:21 +0100
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linker error in 2.6.15-git: drivers/media/video/tuner.o:(.bss+0x0):
 multiple definition of `debug'
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In latest git tree (since 2 days), I have

   CC [M]  drivers/media/video/saa7134/saa7134-dvb.o
   CC      drivers/media/video/saa7127.o
   LD      drivers/media/video/built-in.o
drivers/media/video/tuner.o:(.bss+0x0): multiple definition of `debug'
drivers/media/video/msp3400.o:(.bss+0x0): first defined here
drivers/media/video/cx25840/built-in.o:(.bss+0x0): multiple definition 
of `debug'
drivers/media/video/msp3400.o:(.bss+0x0): first defined here
make[3]: *** [drivers/media/video/built-in.o] Error 1
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2

ciao
	cate
