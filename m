Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264010AbTE3WNv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 18:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264008AbTE3WNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 18:13:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24056 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264026AbTE3WNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 18:13:48 -0400
Date: Sat, 31 May 2003 00:27:02 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Fabio Bracci <fabio@hoendiep.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5.70 compilation fails
Message-ID: <20030530222701.GC2536@fs.tum.de>
References: <Pine.LNX.4.53.0305302318530.31546@hoendiep.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0305302318530.31546@hoendiep.ath.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 11:32:21PM +0200, Fabio Bracci wrote:
> 
> [1.] One line summary of the problem:
> 	The compilation of the kernel 2.5.70 fails
> [2.] Full description of the problem/report:
> 	While making the bzImage, the process exits with the following
> messages:
> ...
>   CC      arch/i386/lib/usercopy.o
>   AS      arch/i386/lib/getuser.o
>   CC      arch/i386/lib/memcpy.o
>   CC      arch/i386/lib/strstr.o
>   CC      arch/i386/lib/dec_and_lock.o
>   AR      arch/i386/lib/lib.a
>   CPP     arch/i386/vmlinux.lds.s
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      vmlinux
> sound/built-in.o(.text+0x9abb): In function `snd_rawmidi_dev_register':
> : undefined reference to `snd_seq_device_new'
> make: *** [vmlinux] Error 1
>...

Please send your .config.

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

