Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265437AbSKRXRE>; Mon, 18 Nov 2002 18:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbSKRXPp>; Mon, 18 Nov 2002 18:15:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35601 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265368AbSKRXPE>;
	Mon, 18 Nov 2002 18:15:04 -0500
Message-ID: <3DD9761A.8030501@pobox.com>
Date: Mon, 18 Nov 2002 18:22:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tr: make CONFIG_TR depend on CONFIG_LLC=y
References: <20021116111344.GD24641@conectiva.com.br> <1037660711.5785.2.camel@rth.ninka.net> <3DD973B6.900@pobox.com> <20021118231926.GG30075@conectiva.com.br>
In-Reply-To: <20021116111344.GD24641@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:

> Em Mon, Nov 18, 2002 at 06:11:50PM -0500, Jeff Garzik escreveu:
>
> >David S. Miller wrote:
> >
> >
> >>On Sat, 2002-11-16 at 03:13, Arnaldo Carvalho de Melo wrote:
> >>
> >>
> >>>	Please pull from:
> >>>
> >>>master.kernel.org:/home/acme/BK/net-2.5
> >>
> >>
> >>Pulled, thanks.
> >
> >hmmm, did you look at the requirements here?
> >
> >when I looked at this a couple weeks ago, it did not seem like the best
> >fix, just the easiest...
>
>
> Previously the 802.2 llc1 code was statically linked when TR was selected,
> problem is now the llc1 code is not separated from the llc2 one, which is
> way bigger, my plans are to:
>
> 1. make llc1 be available separately, so that we can have the previous
>    behaviour
> 2. to make TR be available as a module
>
> Suggestions on better ways to deal with this are welcome...



I could have sworn I fixed this specific problem a month or so ago with 
a Makefile edit and maybe a tiny code edit....  I'll see if I can dig up 
the patch.

	Jeff



