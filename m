Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286331AbRL0QOw>; Thu, 27 Dec 2001 11:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286334AbRL0QOc>; Thu, 27 Dec 2001 11:14:32 -0500
Received: from h103n2fls33o973.telia.com ([213.67.222.103]:27144 "EHLO
	hawaii.cyberzone.lan") by vger.kernel.org with ESMTP
	id <S286328AbRL0QO2>; Thu, 27 Dec 2001 11:14:28 -0500
Date: Thu, 27 Dec 2001 17:14:25 +0100 (CET)
From: Martin Jonsson <marty@rty.nu>
X-X-Sender: marty@hawaii.cyberzone.lan
To: andersg@0x63.nu
cc: linux-kernel@vger.kernel.org
Subject: Re: kiB
In-Reply-To: <20011227160557.GB11106@h55p111.delphi.afb.lu.se>
Message-ID: <Pine.LNX.4.42.0112271710380.865-100000@hawaii.cyberzone.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andersg@0x63.nu wrote:

> this shouldn't be that controversial, as it's only visible to people
> compiling kernels :)
>
> --
>
> //anders/g
>
> diff -ru linux-2.5.2-pre2/arch/i386/boot/tools/build.c
> linux-2.5.2-pre2-lvmfix/arch/i386/boot/tools/build.c
> --- linux-2.5.2-pre2/arch/i386/boot/tools/build.c       Mon Jul  2
> 22:56:40 2001
> +++ linux-2.5.2-pre2-lvmfix/arch/i386/boot/tools/build.c        Thu Dec
> 27
> 16:48:55 2001
> @@ -148,7 +148,7 @@
>         if (fstat (fd, &sb))
>                die("Unable to stat `%s': %m", argv[3]);
>         sz = sb.st_size;
> -       fprintf (stderr, "System is %d kB\n", sz/1024);
> +       fprintf (stderr, "System is %d kiB\n", sz/1024);

Shouldn't that be "KiB" when talking about kibibytes?

>         sys_size = (sz + 15) / 16;
>         /* 0x28000*16 = 2.5 MB, conservative estimate for the current
> maximum */
>         if (sys_size > (is_big_kernel ? 0x28000 : DEF_SYSSIZE))

--
/marty

