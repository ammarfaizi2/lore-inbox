Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288673AbSAKKFX>; Fri, 11 Jan 2002 05:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289124AbSAKKFE>; Fri, 11 Jan 2002 05:05:04 -0500
Received: from polypc17.chem.rug.nl ([129.125.25.92]:62087 "EHLO
	polypc17.chem.rug.nl") by vger.kernel.org with ESMTP
	id <S288710AbSAKKE7>; Fri, 11 Jan 2002 05:04:59 -0500
Message-Id: <m16OyYV-000t5oC@polypc17.chem.rug.nl>
From: chrkok@chem.rug.nl (Christiaan Kok)
Subject: Kernel 2.4.17 gets really slow when handling large files
To: linux-kernel@vger.kernel.org
Date: Fri, 11 Jan 2002 11:04:59 +0100 (CET)
X-hidden-message: <not available>
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear people,

I have a problem with kernel 2.4.17 and as far as I have testen all the 2.4.X
kernels before it. When handling large files, like moving or viewing movies
(700 Mb) (with mplayer) my system suddenly slows down a lot. This can only be
repaired by a reboot. hdparm -Tt /dev/hdX values drop from around 25 MB/s to
around 8 MB/s but DMA is still on (at least that is what hdaprm reports). In
is a such a state it is imposible to burn cds for instance but networkspeed is
unharmed.

My system is a AMD Athlon 650 on a Aopen AK74 (VIA chipset )/
640Mb memory/NVidia TNT2 with X4 driver from NVidia/2 network cards (vanilla)/
SoundBlaster 128 with ALSA drivers/128MB swap.

I tested with 2.4.17/2.4.10/2.4.10-ac4/2.4.6 and they all have this problem.  

Is this a well-known problem for 2.4.X kernels? Is there a work-around 
available, so I can happily watch movies again?

with best regards,

Christiaan Kok
