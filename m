Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267161AbSLKNhf>; Wed, 11 Dec 2002 08:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267150AbSLKNgK>; Wed, 11 Dec 2002 08:36:10 -0500
Received: from ns.suse.de ([213.95.15.193]:9230 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267149AbSLKNfi>;
	Wed, 11 Dec 2002 08:35:38 -0500
Date: Wed, 11 Dec 2002 14:43:23 +0100
From: Stefan Reinauer <stepan@suse.de>
To: Matt Young <wz6b@arrl.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: grub and 2.5.50
Message-ID: <20021211134322.GA23761@suse.de>
References: <200212091640.35716.wz6b@arrl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212091640.35716.wz6b@arrl.net>
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.19 alpha
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Young <wz6b@arrl.net> [021210 01:40]:
> These grub commands work with SUSE 2.4.19-4GB:
> 
>    kernel (hd0,0)/bzImage root=/dev/hda3   vga=791
>    initrd (hd0,0)/initrd
> 
> But with 2.5.50 the kernel panics after Freeing the initrd memory with 
> "Unable te mount root FS, please correct the root= cammand line"

> I have compiled with the required file systems (EXT2,EXT3,REISERFS).

Did you also compile in support for the root device itself (i.e. ide or
scsi driver). These are loaded via the initrd normally on SuSE, which
will not work, if you did not install newer modutils..

  Stefan

-- 
The x86 isn't all that complex - it just doesn't make a lot of
sense.          -- Mike Johnson, Leader of 80x86 Design at AMD
	                          Microprocessor Report (1994)
