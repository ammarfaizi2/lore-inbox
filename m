Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317508AbSGEOTu>; Fri, 5 Jul 2002 10:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317511AbSGEOTt>; Fri, 5 Jul 2002 10:19:49 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:30477 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317508AbSGEOTs>; Fri, 5 Jul 2002 10:19:48 -0400
Date: Fri, 5 Jul 2002 10:27:45 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Klaasjan Brand <kjb@dds.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1 initrd typo fix
In-Reply-To: <1025780141.12120.78.camel@topicus6>
Message-ID: <Pine.LNX.4.44.0207051027270.16528-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Klaasjan,

This is already fixed on my BK tree.

Thanks anyway.

On 4 Jul 2002, Klaasjan Brand wrote:

> Hi there,
>
> I'm totally at a loss to where to send this, but I needed this fix to
> build a kernel with initrd on sparc. Probably on every arch. Seems like
> a typo to me.
>
> Klaasjan
>
>
> --- init/do_mounts.c.orig	Thu Jul  4 12:47:33 2002
> +++ init/do_mounts.c	Thu Jul  4 12:47:50 2002
> @@ -378,7 +378,7 @@
>  	return sys_symlink(path + n + 5, name);
>  }
>
> -#if defined(CONFIG_BLOCK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
> +#if defined(CONFIG_BLK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
>  static void __init change_floppy(char *fmt, ...)
>  {
>  	struct termios termios;
>
>

