Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRAOHLU>; Mon, 15 Jan 2001 02:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129933AbRAOHLK>; Mon, 15 Jan 2001 02:11:10 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:34064 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129631AbRAOHKy>; Mon, 15 Jan 2001 02:10:54 -0500
Date: Mon, 15 Jan 2001 03:20:19 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mark Orr <markorr@intersurf.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-ac9 works, but slower and swappier
In-Reply-To: <XFMail.20010114183953.markorr@intersurf.com>
Message-ID: <Pine.LNX.4.21.0101150318000.12760-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 Jan 2001, Mark Orr wrote:

> 
> I've been running 2.4.0-ac9 for a day and a half now.
> 
> I have pretty low-end hardware (Pentium 1/ 100MHz, 16Mb RAM,
> 17Mb swap)  and it really seems to bog down with anything
> heavy in memory.    Netscape seems to really drag, and any
> Java applets I encounter positively crawl -- you can see
> the individual widgets being drawn.

Could you please try this patch:

http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.1pre3/try_to_free_pages-3.patch

and report results?

Thanks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
