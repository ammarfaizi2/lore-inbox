Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278708AbRJXSap>; Wed, 24 Oct 2001 14:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278707AbRJXSaf>; Wed, 24 Oct 2001 14:30:35 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:24073 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S278708AbRJXSa0>; Wed, 24 Oct 2001 14:30:26 -0400
Date: Wed, 24 Oct 2001 15:10:41 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andre Margis <andre@sam.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.13 high SWAP
In-Reply-To: <200110241920.RAA02577@inter.lojasrenner.com.br>
Message-ID: <Pine.LNX.4.21.0110241509250.885-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ok, 

Have you checked if the amount of data you copied to the tmpfs device is
not way too big to fit in memory ?

Remember: Everything copied to tmpfs will be kept in memory, so if you
simply copy way too much data to tmpfs thats your problem :)

On Wed, 24 Oct 2001, Andre Margis wrote:

> Em Qua 24 Out 2001 14:44, Marcelo Tosatti escreveu:
> Marcelo,
> 
> I restart the test using the same programs, but now I'm using the "cp" on a 
> normal filesystem. At this time everything is OK.
> 
> In the last run we Nedd 30 minutes to the disaster.
> 
> 
> Andre
> 
> > On Wed, 24 Oct 2001, Andre Margis wrote:
> > > Em Qua 24 Out 2001 15:05, Andre Margis escreveu:
> > >
> > > Mor minutes later the machine "froze".
> >
> > Could you please redo the tests without tmpfs?
> >
> > I'm not sure if its the problem, just want to make sure.
> >
> > Thanks.
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 

