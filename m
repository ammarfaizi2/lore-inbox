Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288007AbSAUTvG>; Mon, 21 Jan 2002 14:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288020AbSAUTu4>; Mon, 21 Jan 2002 14:50:56 -0500
Received: from zeus.city.tvnet.hu ([195.38.100.182]:42625 "EHLO
	zeus.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S288007AbSAUTuh> convert rfc822-to-8bit; Mon, 21 Jan 2002 14:50:37 -0500
Subject: Re: Athlon PSE/AGP Bug
From: Sipos Ferenc <sferi@dumballah.tvnet.hu>
To: David Weinehall <tao@acc.umu.se>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Reid Hekman <reid.hekman@ndsu.nodak.edu>, linux-kernel@vger.kernel.org,
        akpm@zip.com.au, alan@lxorg.ukuu.org
In-Reply-To: <20020121203443.K1735@khan.acc.umu.se>
In-Reply-To: <1011610422.13864.24.camel@zeus>
	<E16SkGH-0000Ut-00@the-village.bc.nu> 
	<20020121203443.K1735@khan.acc.umu.se>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.1 (1.0.1-2) 
Date: 21 Jan 2002 20:53:56 +0100
Message-Id: <1011642836.1494.5.camel@zeus.city.tvnet.hu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It has nothing to do with nvidia. I think. I'm using redhat now, but
once I've tried a network installation with suse, and yast crashed at
the beginning. I have played with the boot parameters, and mem=nopentium
was the winner:). I have bought my machine in december, 1999, it's an
athlon 500, so in former athlons the bug exists somehow. The nvidia
module makes crash with the stock kernel irongate agp driver, but not
with the nv agp driver for me, but it's offtopic.

Paco

2002-01-21, H keltezéssel David Weinehall ezt írta:
> On Mon, Jan 21, 2002 at 07:37:45PM +0000, Alan Cox wrote:
> > > That errata lists all Athlon Thunderbirds as affected and all Athlon
> > > Palominos except for stepping A5. 
> > > 
> > > Regardless of specific errata listings, will future workarounds be
> > > enabled based on cpuid or via a test for the bug itself?
> > 
> > That problem shouldnt be hitting Linux x86. I don't know about the
> > Nvidia module but the base kernel shouldnt hit an invlpg on 4Mb pages
> 
> The reference to you in the /.-article is the usual /.-bullshit, I
> gather?!
> 
> 
> /David
>   _                                                                 _
>  // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
> //  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
> \>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

