Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130387AbRAIQt2>; Tue, 9 Jan 2001 11:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131712AbRAIQtM>; Tue, 9 Jan 2001 11:49:12 -0500
Received: from chiara.elte.hu ([157.181.150.200]:22540 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130387AbRAIQsy>;
	Tue, 9 Jan 2001 11:48:54 -0500
Date: Tue, 9 Jan 2001 17:48:32 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Christoph Hellwig <hch@caldera.de>,
        "David S. Miller" <davem@redhat.com>, <riel@conectiva.com.br>,
        <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <E14G1mB-0006vF-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0101091743090.5932-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Alan Cox wrote:

> > > We have already shown that the IO-plugging API sucks, I'm afraid.
> >
> > it might not be important to others, but we do hold one particular
> > SPECweb99 world record: on 2-way, 2 GB RAM, testing a load with a full
>
> And its real world value is exactly the same as the mindcraft NT
> values. Don't forget that.

( what you have not quoted is the part that says that the fileset is 9GB.
This is one of the busiest and most complex block-IO Linux systems i've
ever seen, this is why i quoted it - the talk was about block-IO
performance, and Stephen said that our block IO sucks. It used to suck,
but in 2.4, with the right patch from Jens, it doesnt suck anymore. )

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
