Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315410AbSFAHht>; Sat, 1 Jun 2002 03:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315411AbSFAHhs>; Sat, 1 Jun 2002 03:37:48 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:13493 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S315410AbSFAHhr>; Sat, 1 Jun 2002 03:37:47 -0400
Date: Sat, 1 Jun 2002 09:10:12 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Scott McDermott <vaxerdec@frontiernet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3c59x driver: card not responding after a while
In-Reply-To: <20020531180719.A1860@vaxerdec.homeip.net>
Message-ID: <Pine.LNX.4.44.0206010901560.13503-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmm i can't say i'm experiencing any problems, perhaps this might help;

On Fri, 31 May 2002, Scott McDermott wrote:

> Ronny T. Lampert (EED) on Fri 31/05 17:34 +0200:
> > I'm having (reproducable) problems with the 3c59x driver; after a
> > while (depends on card/traffic), the card doesn't send nor receive
> > anymore.
> 
> - are you using netfilter?

Yep

> - it degrades over time and only after quite a bit of data pumped
>   through it does it hang right? and slowly decreasing throughput right?

Stays consistent, 60+ day uptime.

> - I feel much better to know someone else has this bug! I thought sure I
>   was crazy since I did not hear of this problem from anyone else and
>   905B is very common card.

You might have to plead insanity ;)

> > o RH 7.2 stock (2.4.7)
> 
> wait this worked or didn't? for me 2.4.7 works fine, 2.4.17 does not.

iirc stock RH7.2 and RH7.3 worked fine.

> yep, same thing here...I was to try 2.4.7 3c59x.c with otherwise recent
> kernel but have not got around to this yet...

I'm running 2.4.18-pre7-ac1, 2.4.19-pre8-ac(can't recall), all the boxes 
transfer 2G+ of data a day (home network). IIRC i've been using those 
cards since 2.4.2ish almost without skipping any version updates.

Cards are 3c905B on i440BX, SIS5595 and ServerWorks CNB20LE

I hope this information is of some use to you.

Regards,
	Zwane

-- 
http://function.linuxpower.ca
		

