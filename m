Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284599AbRLZR04>; Wed, 26 Dec 2001 12:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284613AbRLZR0g>; Wed, 26 Dec 2001 12:26:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54538 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284609AbRLZR0S>; Wed, 26 Dec 2001 12:26:18 -0500
Subject: Re: severe slowdown with 2.4 series w/heavy disk access
To: pboley@home.com (Paul Boley)
Date: Wed, 26 Dec 2001 17:36:46 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C2855EF.DC7F584F@home.com> from "Paul Boley" at Dec 25, 2001 05:33:19 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16JHyw-0002TX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When this happens in X, the mouse drags and skips, any processes running
> (like tar/gzip. ls in an empty dir takes about 10 seconds) slow down,
> and it happens usually for about 10sec-2min, often for no apparent
> reason.  The big decompression was just a way I can easily duplicate
> it.  Oddly enough though, according to top, it caches all that memory at

Ok

> once, and my free goes down to 5 megs, with the system hanging/slow to

The free behaviour is correct (free memory is wasted memory). The delays are
obviously not

> under 1% cpu while this happens, and about 50% of the cpu is in use by
> the system (not by any processes that I can see.  kupdated goes up to
> about 0.3% during this)

> > Also what disks do you have and how are they set up ?
> > -

[I meant are they in DMA / UDMA modes ?]

Alan

