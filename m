Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268952AbRG0UYd>; Fri, 27 Jul 2001 16:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268954AbRG0UYZ>; Fri, 27 Jul 2001 16:24:25 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:6419 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S268952AbRG0UYN>; Fri, 27 Jul 2001 16:24:13 -0400
Message-ID: <01e601c116da$68497250$bef7020a@mammon>
From: "Jeremy Linton" <jlinton@interactivesi.com>
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>, "Samuel Dupas" <samuel@dupas.com>
In-Reply-To: <Pine.LNX.4.33L.0107271616170.5582-100000@duckman.distro.conectiva>
Subject: Re: swap_free: swap-space map bad (entry 00000100)
Date: Fri, 27 Jul 2001 15:26:19 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> On Fri, 27 Jul 2001, Samuel Dupas wrote:
> > On Fri, 27 Jul 2001 12:29:18 -0500
> > "Jeremy Linton" <jlinton@interactivesi.com> wrote:
> > > Did you do a 'swapoff' at some point before this?
> > >
> >
> > No, I didn't change anything. I just put stress on it with ab to
> > test the machine but it felt down :-((
> >
> > Others ideas ?
>
> The memory corruption you saw usually (almost always)
> indicates a hardware problem. It may not have shown up
> during normal usage because without ab your RAM has
> more idle time and can keep up refreshing itself
> easily.

I asked about the swapoff path because I have a couple of stable MP boxes
that exhibit swap map corruption (similar to what he appears to be seeing)
during/after a swapoff operation in 2.4. I presented a patch a couple weeks
ago that fixes some of the problems that I am seeing. A quick look at 2.2.19
makes it look the same problems might exist there as well. If he isn't doing
swapoff then my fixes probably won't help him.



                                                                jlinton


