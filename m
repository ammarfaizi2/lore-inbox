Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318815AbSHLUvi>; Mon, 12 Aug 2002 16:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318816AbSHLUvi>; Mon, 12 Aug 2002 16:51:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28409 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318815AbSHLUvh>; Mon, 12 Aug 2002 16:51:37 -0400
Date: Mon, 12 Aug 2002 22:55:21 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Peter Klotz <peter.klotz@AON.AT>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 and 2.4.20-pre1 don't boot
In-Reply-To: <000501c24230$8a29bdd0$8c00000a@sledgehammer>
Message-ID: <Pine.NEB.4.44.0208122250590.14606-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Peter Klotz wrote:

> Hi

Hi Peter,

> Up to 2.4.19-rc1 my system worked fine but 2.4.19 and 2.4.20-pre1 produce
> the following message at startup:
>
> Mounting root filesystem
> ide-floppy driver 0.99.newide
> kmod: failed to exec /sbin/modprobe -s -k ide-cd, errno = 2
> hda: driver not present
> mount: error 6 mounting ext3
> pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
> Freeing unused kernel memory: 108k freed
> Kernel panic: No init found. Try passing init= option to kernel.
>
> I have no idea what causes the problem since I did not change the kernel
> configuration.
>
> The system configuration is as follows:
> Athlon XP 1600+
> Asus A7V266-E (VIA KT266A)
> 512MB RAM
> hda, hdc are IDE Harddisks
>
> Any suggestions welcome.

what type of IDE controller is in this machine?

Is there any other error message above the startup message you quoted?

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

