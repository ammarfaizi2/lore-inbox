Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132040AbRBAXum>; Thu, 1 Feb 2001 18:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131911AbRBAXud>; Thu, 1 Feb 2001 18:50:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:27405 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131822AbRBAXu0>; Thu, 1 Feb 2001 18:50:26 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch] tmpfs for 2.4.1
Date: 1 Feb 2001 15:50:02 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <95csna$vb6$1@cesium.transmeta.com>
In-Reply-To: <20010123205315.A4662@werewolf.able.es> <m3lmrqrspv.fsf@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m3lmrqrspv.fsf@linux.local>
By author:    Christoph Rohland <cr@sap.com>
In newsgroup: linux.dev.kernel
>
> Hi,
> 
> here is the latest version of my tmpfs patch against 2.4.1
> 
> Have fun
>                 Christoph
> 
> diff -uNr 2.4.1/Documentation/Changes 2.4.1-tmpfs/Documentation/Changes
> --- 2.4.1/Documentation/Changes	Tue Jan 30 11:06:59 2001
> +++ 2.4.1-tmpfs/Documentation/Changes	Thu Feb  1 22:04:13 2001
> @@ -114,20 +114,6 @@
>  DevFS is now in the kernel.  See Documentation/filesystems/devfs/* in
>  the kernel source tree for all the gory details.
>  
> -System V shared memory is now implemented via a virtual filesystem.
> -You do not have to mount it to use it. SYSV shared memory limits are
> -set via /proc/sys/kernel/shm{max,all,mni}.  You should mount the
> -filesystem under /dev/shm to be able to use POSIX shared
> -memory. Adding the following line to /etc/fstab should take care of
> -things:
> -
> -none		/dev/shm	shm		defaults	0 0
> -
> -Remember to create the directory that you intend to mount shm on if
> -necessary (The entry is automagically created if you use devfs). You
> -can set limits for the number of blocks and inodes used by the
> -filesystem with the mount options nr_blocks and nr_inodes.
> -
>  The Logical Volume Manager (LVM) is now in the kernel.  If you want to
>  use this, you'll need to install the necessary LVM toolset.
>  

What happened with this being a management tool for shared memory
segments?!

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
