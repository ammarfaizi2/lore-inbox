Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281659AbRLICOi>; Sat, 8 Dec 2001 21:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281846AbRLICO3>; Sat, 8 Dec 2001 21:14:29 -0500
Received: from shell.cyberus.ca ([216.191.240.114]:25595 "EHLO
	shell.cyberus.ca") by vger.kernel.org with ESMTP id <S281652AbRLICOO>;
	Sat, 8 Dec 2001 21:14:14 -0500
Date: Sat, 8 Dec 2001 21:10:41 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: bert hubert <ahu@ds9a.nl>
cc: <lartc@mailman.ds9a.nl>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: CBQ and all other qdiscs now REALLY completely documented
 (almost!)
In-Reply-To: <20011209023029.A25580@outpost.ds9a.nl>
Message-ID: <Pine.GSO.4.30.0112082108070.4764-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Dec 2001, bert hubert wrote:

> On Sat, Dec 08, 2001 at 08:14:10PM -0500, jamal wrote:
>
> AFAICT, the priomap maps skb->priority to band. So the translation is as
> follows:
>

yes ;->

> >
> > so do prio and pfifo_fast (as i am sure you are aware)
>
> Of course, but only CBQ (& HTB, by the way) can extract a classid directly
> from it, without a priomap. Devik is planning to learn HTB to extract a
> classid directly from the fwmark, to skip a layer of indirection.
>

I am not sure if this is such a nice hack. Whats wrong with with using the
fwmark classifier to select classes?

cheers,
jamal

