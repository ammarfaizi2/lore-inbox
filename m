Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266104AbRF2Ptd>; Fri, 29 Jun 2001 11:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265997AbRF2PtY>; Fri, 29 Jun 2001 11:49:24 -0400
Received: from beppo.feral.com ([192.67.166.79]:30470 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S266104AbRF2PtP> convert rfc822-to-8bit;
	Fri, 29 Jun 2001 11:49:15 -0400
Date: Fri, 29 Jun 2001 08:48:39 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: <mjacob@feral.com>
To: =?ISO-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Qlogic Fiber Channel
In-Reply-To: <20010629173631.A15608@pc8.lineo.fr>
Message-ID: <20010629083938.G13977-100000@wonky.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You know, this is probably slightly OTm, but I've been getting closer
and closer to what I consider 'happy' for my QLogic megadriver under
Linux- I have just a tad more to deal with in local loop failures (I
spent far too much time working on fabric only)- but I've been happier
with it and need to close it up and move on.

I *do* plan to finish IP support eventually.

I certainly would like to get more feedback about it.

Feel free to pick up-

bk://blade.feral.com:9002
ftp://ftp.feral.com/pub/isp/isp_dist.tgz

It's certainly got the latest f/w in it which you can try and use with
qlogicfc.

-matt


On Fri, 29 Jun 2001, [ISO-8859-1] christophe barbé wrote:

>
> Le ven, 29 jun 2001 17:09:56, Alan Cox a écrit :
> > > From my point of view, this driver is sadly broken. The fun part is
> that
> > > the qlogic driver is certainly based on this one too (look at the code,
> > > the drivers differs not so much).
> >
> > And if the other one is stable someone should spend the time merging the
> > two.
>
> That what I would like to try but It seems impossible without an
> IP-enhanced firmware. I could try with the old firmware but I believe that
> the new code from QLogic use some features that are only in recent
> firmware.
>
> >
> > > IMHO the qlogicfc driver should be removed from the kernel tree and
> > > perhaps replaced by the last qlogic one. We then lost the IP support
> > > but this is a broken support.
> >
> > For 2.5 that may wellk make sense. Personally I'd prefer someone worked
> > out
> > why the qlogicfc driver behaves as it does. It sounds like two small bugs
> > nothing more
> >
> > 1.	That the FC event code wasnt updated from 2.2 so now runs
> > 	with IRQ's off when it didnt expect it
> >
> > 2.	That someone has a slight glitch in the queue handling.
>
> This driver is already buggy under kernel 2.2. This driver is a well known
> source of problems in the GFS mailing lists.
>
> I believe that the better thing to do is to use the qlogic driver. If we
> manage to get a recent IP-enhanced firmware we could rewrite the missing IP
> code. Half of the job is already done in the source of this driver.
>
> I didn't manage to reach the good person from qlogic. Perhaps someone would
> have better results.
>
> Christophe
>
> --
> Christophe Barbé
> Software Engineer - christophe.barbe@lineo.fr
> Lineo France - Lineo High Availability Group
> 42-46, rue Médéric - 92110 Clichy - France
> phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
> http://www.lineo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

