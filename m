Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbRAaBvN>; Tue, 30 Jan 2001 20:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRAaBvD>; Tue, 30 Jan 2001 20:51:03 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:51383 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S131386AbRAaBuv>;
	Tue, 30 Jan 2001 20:50:51 -0500
Date: Tue, 30 Jan 2001 20:45:59 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Rick Jones <raj@cup.hp.com>
cc: Ion Badulescu <ionut@cs.columbia.edu>, Andrew Morton <andrewm@uow.edu.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: Still not sexy! (Re: sendfile+zerocopy: fairly sexy (nothing to
  dowith ECN)
In-Reply-To: <3A77661C.5D7FD4C@cup.hp.com>
Message-ID: <Pine.GSO.4.30.0101302039580.3017-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Jan 2001, Rick Jones wrote:

> > ** I reported that there was also an oddity in throughput values,
> > unfortunately since no one (other than me) seems to have access
> > to a gige cards in the ZC list, nobody can confirm or disprove
> > what i posted. Here again as a reminder:
> >
> > Kernel     |  tput  | sender-CPU | receiver-CPU |
> > -------------------------------------------------
> > 2.4.0-pre3 | 99MB/s |   87%      |  23%         |
> > NSF        |        |            |              |
> > -------------------------------------------------
> > 2.4.0-pre3 | 86MB/s |   100%     |  17%         |
> > SF         |        |            |              |
> > -------------------------------------------------
> > 2.4.0-pre3 | 66.2   |   60%      |  11%         |
> > +ZC        | MB/s   |            |              |
> > -------------------------------------------------
> > 2.4.0-pre3 | 68     |   8%       |  8%          |
> > +ZC  SF    | MB/s   |            |              |
> > -------------------------------------------------
> >
> > Just ignore the CPU readings, focus on throughput. And could someone plese
> > post results?
>
> In the spirit of the socratic method :)

;->

>
> Is your gige card based on Alteon?

Yes, sir, it is. To be precise:

** Sender: SMP-PII-450Mhz, ASUS m/board; 3com version of acenic
- 1M version
** receiver: same hardware; acenic alteon card - 1M version

> How does ZC/SG change the nature of the packets presented to the NIC?

what do you mean? I am _sure_ you know how SG/ZC work. So i am suspecting
more than socratic view on life here. Could be influence from Aristotle;->

> How well does the NIC do with that changed nature?
>

Hard question to answer ;-> I havent done any analysis at that level

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
