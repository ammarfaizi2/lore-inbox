Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVHUEtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVHUEtr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 00:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVHUEtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 00:49:47 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:25255 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750794AbVHUEtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 00:49:46 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Date: Sun, 21 Aug 2005 14:49:38 +1000
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <43001E18.8020707@bigpond.net.au> <200508211422.16850.kernel@kolivas.org> <6bffcb0e05082021446aeb8004@mail.gmail.com>
In-Reply-To: <6bffcb0e05082021446aeb8004@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508211449.38871.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Aug 2005 14:44, Michal Piotrowski wrote:
> On 8/21/05, Con Kolivas <kernel@kolivas.org> wrote:
> > Well it will survive all right, but eventually get into swap thrash
> > territory and that's not a meaningful cpu scheduler benchmark.
> >
> > Cheers,
> > Con
>
> Ok. How about make -j? It's one of kernbench test runs, on my box load
> average > 1500 ;).

Just do that if you wish to overload the system. It's a vm benchmark. No doubt 
the cpu scheduler contributes to how the vm behaves, but it isn't a primary 
cpu scheduler test.

> BTW I have only 1 gb ram, so high values of -j are road to hell for my
> system... I'm still learning, but it's fun ;). Now I'll try your latest
> -ck. Thanks for "1Gb Low Memory Support".

You're welcome,
Con
