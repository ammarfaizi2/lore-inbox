Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSFCXKQ>; Mon, 3 Jun 2002 19:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315748AbSFCXKP>; Mon, 3 Jun 2002 19:10:15 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:48884 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315746AbSFCXKN>; Mon, 3 Jun 2002 19:10:13 -0400
Subject: Re: Another -pre
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Pawel Kot <pkot@linuxnews.pl>, lkml <linux-kernel@vger.kernel.org>,
        Andre Hedrick <andre@serialata.org>
In-Reply-To: <Pine.LNX.4.44.0206031155200.4146-100000@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jun 2002 01:15:10 +0100
Message-Id: <1023149710.6773.82.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-03 at 15:55, Marcelo Tosatti wrote:
> On Mon, 3 Jun 2002, Pawel Kot wrote:
> 
> > On Mon, 3 Jun 2002, Marcelo Tosatti wrote:
> >
> > > Due to some missing network fixes and -ac merge, I'll release another -pre
> > > later today.
> > >
> > > -rc should be out by the end of the week.
> >
> > Would you please consider merging some IDE updates before releasing
> > 2.4.19? Current version remains unusable for me.
> > See http://marc.theaimsgroup.com/?l=linux-kernel&m=102277249800423&w=2
> > and followers for more detailes.
> 
> Andre,
> 
> Have you looked into this problem ?

With the current code I've got these items on my list I class as
problematic.

1 Weird corruption report with AMD chipset in PIO mode
1 NULL pointer crash report on SiS chipset
2 Intel 845G issues (PIO only, incorrect BIOS setup)
1 set of requested Promise changes 

The 845G and Promise ones are present in both. The AMD one is utterly
weird and I'm still looking at the SiS one.


