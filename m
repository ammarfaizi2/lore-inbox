Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWFUSsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWFUSsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 14:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWFUSsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 14:48:47 -0400
Received: from aa004msr.fastwebnet.it ([85.18.95.67]:393 "EHLO
	aa004msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932329AbWFUSsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 14:48:46 -0400
Date: Wed, 21 Jun 2006 20:48:14 +0200
From: Mattia Dongili <malattia@linux.it>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hpa@zytor.com
Subject: Re: 2.6.17-mm1
Message-ID: <20060621184814.GQ24595@inferi.kami.home>
Mail-Followup-To: Martin Bligh <mbligh@mbligh.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	hpa@zytor.com
References: <44998DCB.1030703@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44998DCB.1030703@mbligh.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.17-rc4-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 11:19:55AM -0700, Martin Bligh wrote:
> Seems to dive into an endless loop in compile.
> 
> http://test.kernel.org/abat/37068/debug/test.log.0
> 
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   CC      init/initramfs.o
>   CC      init/calibrate.o
>   LD      init/built-in.o
>   HOSTCC  usr/gen_init_cpio
>   SYMLINK usr/include/asm -> include/asm-x86_64
>   GEN     usr/klibc/syscalls/SYSCALLS.i
>   GEN     usr/klibc/syscalls/syscalls.nrs
>   GEN     usr/klibc/syscalls/typesize.c
>   KLIBCCC usr/klibc/syscalls/typesize.o
>   OBJCOPY usr/klibc/syscalls/typesize.bin
[...]
> etc etc. for ever.
> 
> On both x86_64 and ppc64.

me too, on 586

.config is here: http://oioio.altervista.org/linux/config-2.6.17-mm1
-- 
mattia
:wq!
