Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132907AbRAJBnG>; Tue, 9 Jan 2001 20:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130548AbRAJBm5>; Tue, 9 Jan 2001 20:42:57 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:54277 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129903AbRAJBmv>; Tue, 9 Jan 2001 20:42:51 -0500
Date: Wed, 10 Jan 2001 01:41:55 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] n_r3964: restore_flags on failure
In-Reply-To: <20010109143328.B21057@conectiva.com.br>
Message-ID: <Pine.LNX.4.30.0101100140380.7564-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Arnaldo Carvalho de Melo wrote:

> --- linux-2.4.0-ac4/drivers/char/n_r3964.c	Tue Dec 19 11:25:34 2000
> +++ linux-2.4.0-ac4.acme/drivers/char/n_r3964.c	Tue Jan  9 14:23:07 2001

> +      	 restore_flags(flags);

/me scratches head...

Err.... is there any reason to believe that the locking therein actually
works at all?

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
