Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317320AbSGDCWP>; Wed, 3 Jul 2002 22:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317324AbSGDCWP>; Wed, 3 Jul 2002 22:22:15 -0400
Received: from flrtn-5-m1-95.vnnyca.adelphia.net ([24.55.70.95]:45696 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S317320AbSGDCWM>;
	Wed, 3 Jul 2002 22:22:12 -0400
Message-ID: <3D23B1E8.5060504@tmsusa.com>
Date: Wed, 03 Jul 2002 19:24:40 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Wiederhold <U.Wiederhold@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: nvidia driver won't compile with 2.4.19-rc1
References: <20020703214757.GA504@sky.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are using an old nvidia driver -

1.0-2960 compiles and works fine here.

Joe

Ulrich Wiederhold wrote:

>Hello,
>if I make an update-modules, I get:
>depmod: *** Unresolved symbols in
>/lib/modules/2.4.19-rc1/kernel/drivers/scsi/sr_mod.o
>
>and if I wanna compile "NVIDIA_kernel-1.0-2880":
>
>home:/NVIDIA_kernel-1.0-2880# make
>cc -c -Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts
>-Wparentheses -Wpointer-arith -Wcast-qual -Wno-multichar  -O -MD
>-D__KERNEL__ -DMODULE -D_LOOSE_KERNEL_NAMES -D_X86=1 -Di386=1 -DUNIX
>-DLINUX -DNV4_HW -DNTRM -DRM20 -D_GNU_SOURCE -DRM_HEAPMGR
>-D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE  -DNV_MAJOR_VERSION=1
>-DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=2880   -I.
>-I/lib/modules/2.4.19-rc1/build/include -Wno-cast-qual nv.c
>cc -c -Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts
>-Wparentheses -Wpointer-arith -Wcast-qual -Wno-multichar  -O -MD
>-D__KERNEL__ -DMODULE -D_LOOSE_KERNEL_NAMES -D_X86=1 -Di386=1 -DUNIX
>-DLINUX -DNV4_HW -DNTRM -DRM20 -D_GNU_SOURCE -DRM_HEAPMGR
>-D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE  -DNV_MAJOR_VERSION=1
>-DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=2880   -I.
>-I/lib/modules/2.4.19-rc1/build/include -Wno-cast-qual os-interface.c
>os-interface.c:1207: warning: `wb_list' defined but not used
>cc -c -Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts
>-Wparentheses -Wpointer-arith -Wcast-qual -Wno-multichar  -O -MD
>-D__KERNEL__ -DMODULE -D_LOOSE_KERNEL_NAMES -D_X86=1 -Di386=1 -DUNIX
>-DLINUX -DNV4_HW -DNTRM -DRM20 -D_GNU_SOURCE -DRM_HEAPMGR
>-D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE  -DNV_MAJOR_VERSION=1
>-DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=2880   -I.
>-I/lib/modules/2.4.19-rc1/build/include -Wno-cast-qual os-registry.c
>ld -r -o Module-linux nv.o os-interface.o os-registry.o 
>ld -r -o NVdriver Module-linux Module-nvkernel
>size NVdriver
>   text    data     bss     dec     hex filename
>    779245   52020   52364  883629   d7bad NVdriver
>    depmod: *** Unresolved symbols in
>    /lib/modules/2.4.19-rc1/kernel/drivers/scsi/sr_mod.o
>    make: *** [package-install] Fehler 1
>    home:/home/fzzgrr/NVIDIA_kernel-1.0-2880# update-modules 
>    depmod: *** Unresolved symbols in
>    /lib/modules/2.4.19-rc1/kernel/drivers/scsi/sr_mod.o
>
>I get the same error. I had no problems compiling them with 2.4.17-rc2.
>Any ideas what to do?
>
>Uli
>
>  
>



