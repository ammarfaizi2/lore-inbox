Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261508AbSJUQjG>; Mon, 21 Oct 2002 12:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbSJUQjG>; Mon, 21 Oct 2002 12:39:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:53428 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261508AbSJUQjE>; Mon, 21 Oct 2002 12:39:04 -0400
Date: Mon, 21 Oct 2002 14:07:58 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compile fix for dmi_scan.c in 2.4.bk-current
In-Reply-To: <1035215203.28189.167.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44L.0210211404570.11201-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 21 Oct 2002, Alan Cox wrote:

> On Tue, 2002-10-15 at 20:03, Marcelo Tosatti wrote:
> > I'll remove the dmi update from Alan for 2.4.20-pre.
> >
> > Thats a 2.4.21-pre thing.
>
> Its very much a 2.4.20 thing. Its just that it accidentally acquired the
> HP entry as well which we dont want.
>
> Lose the problem function and the HP specific quirk and you'll get the
> bits that actually do matter

I merged the HP Pavilion quirks on my tree and then backed it all out
later because I thought the changes were not necessary for 2.4.20.

Which issues the DMI update is addressing?

