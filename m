Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbSL1IY3>; Sat, 28 Dec 2002 03:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSL1IY3>; Sat, 28 Dec 2002 03:24:29 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:2783 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S265567AbSL1IY2>; Sat, 28 Dec 2002 03:24:28 -0500
Date: Sat, 28 Dec 2002 03:32:44 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Samuel Flory <sflory@rackable.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, Janet Morgan <janetmor@us.ibm.com>,
       "" <linux-scsi@vger.kernel.org>, "" <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G
In-Reply-To: <3E03BB0D.5070605@rackable.com>
Message-ID: <Pine.LNX.4.50L.0212280331110.30646-100000@freak.distro.conectiva>
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com>
 <176730000.1040430221@aslan.btc.adaptec.com> <3E03BB0D.5070605@rackable.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Dec 2002, Samuel Flory wrote:

> Justin T. Gibbs wrote:
>
> >>I have an Adaptec AIC-7897 Ultra2 SCSI adapter on a system with 8G
> >>of physical memory.  The adapter is using bounce buffers when DMA'ing
> >>to memory >4G because of a bug in the aic7xxx driver.
> >>
> >>
> >
> >This has been fixed in both the aic7xxx and aic79xx drivers for some
> >time.  The problem is that these later revisions have not been integrated
> >into the mainline trees.
> >
> >
> >
>   Marcelo, what is required get the aic79xx driver, and the aic7xxx
> updates into 2.4.21?  A number of linux distros are already using it.
>  It would really help people using board with the U320.
>
>     I've been using both drivers for some time with no issues.  Or maybe
> you'd prefer Alan put it in his tree 1st?

Ho, hum, I prefer getting it tested in -ac for a while first.
