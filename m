Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRBTDPL>; Mon, 19 Feb 2001 22:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129358AbRBTDPC>; Mon, 19 Feb 2001 22:15:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25094 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129115AbRBTDOx>; Mon, 19 Feb 2001 22:14:53 -0500
Subject: Re: [PATCH] exclusive wakeup for lock_buffer
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Tue, 20 Feb 2001 03:12:15 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.21.0102192245340.3338-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Feb 19, 2001 10:51:36 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14V3Du-0005Py-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux/include/linux/locks.h.orig	Mon Feb 19 23:16:50 2001
> +++ linux/include/linux/locks.h	Mon Feb 19 23:21:48 2001
> @@ -13,6 +13,7 @@
>   * lock buffers.
>   */
>  extern void __wait_on_buffer(struct buffer_head *);
> +extern void __lock_buffer(struct buffer_head *);

So are we starting 2.5 now ?
