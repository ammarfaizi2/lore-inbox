Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269541AbRHHVJC>; Wed, 8 Aug 2001 17:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269542AbRHHVIw>; Wed, 8 Aug 2001 17:08:52 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:17939 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S269541AbRHHVIm>; Wed, 8 Aug 2001 17:08:42 -0400
Date: Wed, 8 Aug 2001 21:08:22 +0000 (GMT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: jury gerold <geroldj@grips.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon/MSI mobo combo broken?
In-Reply-To: <3B717220.8050308@grips.com>
Message-ID: <Pine.LNX.4.10.10108082057430.10284-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you have PC100 SDRAM try to replace it with PC133.

ugh, this is the same (mistaken) approach as turning off CONFIG_MK7:
cripple performance enough that your system works.  turning off 
CONFIG_MK7 disables Arjan's nice code in mmx.c which delivers 
2-4x the copy/zero-page bandwidth...

there *are* stable via/athlon systems, and that indicates that the 
problem is not inherent to the chipset.  I have a gigabyte ga-7zx,
duron/600, pc133 system that has always been rock-solid.  and I 
recently built an Asus a7v-133, tbird/1199, pc133 system that is
also entirely stable.  both run cas2 pc133, CONFIG_MK7 kernels, etc.
both have fairly generous power supplies.

so far, the only plausible theory is that some individual factor(s)
(MB, bios settings, power quality, dram quality, etc) causes 
the instability that some people report.

regards, mark hahn.

