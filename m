Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbRAEOei>; Fri, 5 Jan 2001 09:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRAEOe3>; Fri, 5 Jan 2001 09:34:29 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:6896 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129413AbRAEOeQ>; Fri, 5 Jan 2001 09:34:16 -0500
Date: Fri, 5 Jan 2001 12:33:58 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Brad Hartin <bhartin@satx.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18: do_try_to_free_pages
In-Reply-To: <Pine.LNX.4.21.0101050732330.10424-100000@osprey.hartinhome.net>
Message-ID: <Pine.LNX.4.21.0101051232150.1295-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001, Brad Hartin wrote:

> Jan  4 00:06:05 osprey kernel: VM: do_try_to_free_pages failed for X...
> Jan  4 00:06:06 osprey last message repeated 6 times

This bug is fixed in 2.2.19-pre2 and later.
Oh, and 2.4.0 of course doesn't have it either ;)

[If you don't mind, please help test 2.4.0 a bit more. I'm
pretty confident it's better than 2.2.18 when under load,
but maybe the device drivers you use still need some tweaking]

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to loose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
