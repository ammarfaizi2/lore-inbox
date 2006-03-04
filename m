Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751886AbWCDR11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbWCDR11 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWCDR11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:27:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13587 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751886AbWCDR10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:27:26 -0500
Date: Sat, 4 Mar 2006 18:27:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lew Glendenning <lglendenning@lnxi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LD internal error while compiling 2.6.15 kernel
Message-ID: <20060304172726.GI9295@stusta.de>
References: <4403C403.90303@lnxi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4403C403.90303@lnxi.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 08:31:15PM -0700, Lew Glendenning wrote:
> On an ASUS A8N-SLI with an AMD Athlon 64  X2 4400+, 4GB of PC3200 
> memory, 2 300GB SATA drives, the command:
> 
>    lew@harlow:~/kernels/linux-2.6.15$ time make bzImage
> 
> succeeds, but the command:
> 
>   lew@harlow:~/kernels/linux-2.6.15/$  time make -j4 bzImage
> 
> Eventually produces :
>  LD      net/built-in.o
>  GEN     .version
>  CHK     include/linux/compile.h
>  UPD     include/linux/compile.h
>  CC      init/version.o
>  LD      init/built-in.o
>  LD      .tmp_vmlinux1
>  ld: BFD 2.16.1 Debian GNU/Linux internal error, aborting at          
>    ../../bfd/reloc.c line 444 in bfd_get_reloc_size
> 
> ld: Please report this bug.
>...

That's an internal error in ld, and the appriopriate contact to ask for 
support is therefore the vendor of your binutils (Debian).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

