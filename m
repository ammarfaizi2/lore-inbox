Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbTBPAiJ>; Sat, 15 Feb 2003 19:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTBPAiJ>; Sat, 15 Feb 2003 19:38:09 -0500
Received: from c16639.thoms1.vic.optusnet.com.au ([210.49.244.5]:17284 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S265469AbTBPAiI>;
	Sat, 15 Feb 2003 19:38:08 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: tbench as a load - DDOS attack?
Date: Sun, 16 Feb 2003 11:48:02 +1100
User-Agent: KMail/1.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200302161007.25149.kernel@kolivas.org> <Pine.LNX.4.50.0302151823130.16012-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0302151823130.16012-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302161148.02045.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2003 10:24 am, Zwane Mwaikambo wrote:
> On Sun, 16 Feb 2003, Con Kolivas wrote:
> > Zwane M suggested using tbench as a load to test one of his recent
> > patches and gave me the idea to try using tbench_load in contest. Here
> > are the first set of results I got while running tbench 4 continuously
> > (uniprocessor machine):
> >
> > tbench_load:
> > Kernel         [runs]   Time    CPU%
> > test2420            1   180     38.9
> > test2561            1   970     7.7
> >
> > This is a massive difference. Sure tbench was giving better numbers on
> > 2.5.61 but it caused a massive slowdown. I wondered whether this
> > translates into being more susceptible to ping floods or DDOS attacks?
> > You should have seen tbench 16 - 3546 seconds!
> >
> > comments?
>
> Are you running this via loopback? Can you send a profile during the
> 2.4.20 run?

Loopback. 

Con
