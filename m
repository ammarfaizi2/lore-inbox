Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264210AbSJNKZp>; Mon, 14 Oct 2002 06:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbSJNKZp>; Mon, 14 Oct 2002 06:25:45 -0400
Received: from [66.70.28.20] ([66.70.28.20]:61191 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S264210AbSJNKZp>; Mon, 14 Oct 2002 06:25:45 -0400
Date: Mon, 14 Oct 2002 12:25:27 +0200
From: DervishD <raul@pleyades.net>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] mmap.c (do_mmap_pgoff), against 2.4.19 and 2.4.20-pre10
Message-ID: <20021014102527.GD96@DervishD>
References: <20021014093622.GA96@DervishD> <20021014110947.B32186@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021014110947.B32186@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Organization: Pleyades Net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Russell :))

>        If the recipient is supposed to use the -pN option, do not
>        send output that looks like this:
> 
>           diff -Naur v2.0.29/prog/README prog/README
>           --- v2.0.29/prog/README   Mon Mar 10 15:13:12 1997
>           +++ prog/README   Mon Mar 17 14:58:22 1997

    Sorry, was a typo, you're right...

> Also, you should generate the patches without the "/usr/src/" prefix.
> So it should look like this:
> --- linux/mm/mmap.c.orig	2002-10-14 11:16:40.000000000 +0200
> +++ linux/mm/mmap.c	2002-10-14 11:19:32.000000000 +0200

    I did it on purpose, but you're right, the prefix is useless and
can cause problems. I'll resend.

    Thanks for your warning :))
    Raúl
