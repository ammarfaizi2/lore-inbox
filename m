Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSLMGvS>; Fri, 13 Dec 2002 01:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSLMGvR>; Fri, 13 Dec 2002 01:51:17 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:34805 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S261529AbSLMGvO> convert rfc822-to-8bit; Fri, 13 Dec 2002 01:51:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Matt Young <wz6b@arrl.net>
Reply-To: wz6b@arrl.net
To: Alex Tomas <bzzz@tmi.comex.ru>, Stefan Reinauer <stepan@suse.de>
Subject: Re: grub and 2.5.50
Date: Thu, 12 Dec 2002 22:58:24 -0800
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200212091640.35716.wz6b@arrl.net> <20021211134322.GA23761@suse.de> <m3wumfz8ne.fsf@lexa.home.net>
In-Reply-To: <m3wumfz8ne.fsf@lexa.home.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212122258.25333.wz6b@arrl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got things going by doing that trick, good tip,

On Thursday 12 December 2002 05:09, Alex Tomas wrote:
> >>>>> Stefan Reinauer (SR) writes:
>
>  SR> * Matt Young <wz6b@arrl.net> [021210 01:40]:
>  >> These grub commands work with SUSE 2.4.19-4GB:
>  >>
>  >> kernel (hd0,0)/bzImage root=/dev/hda3 vga=791 initrd
>  >> (hd0,0)/initrd
>  >>
>  >> But with 2.5.50 the kernel panics after Freeing the initrd memory
>  >> with "Unable te mount root FS, please correct the root= cammand
>  >> line"
>  >>
>  >> I have compiled with the required file systems
>  >> (EXT2,EXT3,REISERFS).
>
>  SR> Did you also compile in support for the root device itself
>  SR> (i.e. ide or scsi driver). These are loaded via the initrd
>  SR> normally on SuSE, which will not work, if you did not install
>  SR> newer modutils..
>
> First of all, 2.5.10 has sysfs-related bug. try to replace root=/dev/hda3
> by root=303
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

