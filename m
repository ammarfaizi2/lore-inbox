Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTFWO4U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 10:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbTFWO4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 10:56:20 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:56705 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S261245AbTFWO4S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 10:56:18 -0400
To: John Weber <weber@sixbit.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.73 Mouse
References: <3EF7010C.5090000@sixbit.org>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 23 Jun 2003 17:10:21 +0200
In-Reply-To: <3EF7010C.5090000@sixbit.org>
Message-ID: <87brwoeso2.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ditto, Compaq evo n800c lapdog here.

mvh,
A

John Weber <weber@sixbit.org> writes:

> My mouse suddenly stopped working with 2.5.73.  I am using a Synaptics
> Touchpad --
> with comes with a Dell laptop.  (I will test with an external mouse later).
> 
> The SERIO I8042 driver seems to find my mouse, interrupts are firing,
> and I enabled
> the old /dev/psaux so that userland doesn't see anything
> different. Most importantly,
> the same config worked with 2.5.72.  I noticed that dmesg was slightly
> different across
> the two versions which suggests that something did change.
> 
> --- dmesg-2.5.72        2003-06-23 09:11:32.000000000 -0400
> +++ dmesg-2.5.73        2003-06-23 09:12:52.000000000 -0400
> @@ -1,21 +1,4 @@
> -1d490
> -pass
> -page 3
> -f79c892a338f4a8b
> -pass
> -
> -testing des ecb encryption chunking scenario B
> -page 1
> -c957
> -pass
> -page 2
> -44
> -pass
> -page 3
> -256a5e
> -pass
> -page 4
> -d31df79c892a338f4a8bb49926f71fe1d490
> +1fe1d490
>   pass
> 
>   testing des ecb encryption chunking scenario C
> @@ -523,7 +506,15 @@
>   serio: i8042 AUX0 port at 0x60,0x64 irq 12
>   serio: i8042 AUX1 port at 0x60,0x64 irq 12
>   serio: i8042 AUX2 port at 0x60,0x64 irq 12
> -input: PS/2 Synaptics TouchPad on isa0060/serio4
> +Synaptics Touchpad, model: 1
> + Firware: 5.8
> + 180 degree mounted touchpad
> + Sensor: 18
> + new absolute packet format
> + Touchpad has extended capability bits
> + -> multifinger detection
> + -> palm detection
> +input: Synaptics Synaptics TouchPad on isa0060/serio4
>   serio: i8042 AUX3 port at 0x60,0x64 irq 12
>   input: AT Set 2 keyboard on isa0060/serio0
>   serio: i8042 KBD port at 0x60,0x64 irq 1
> @@ -548,7 +539,7 @@
>   Initializing IPsec netlink socket
>   NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>   VFS: Mounted root (ext2 filesystem) readonly.
> -Freeing unused kernel memory: 172k freed
> +Freeing unused kernel memory: 176k freed
>   Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1
> 
> Any suggestions?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
