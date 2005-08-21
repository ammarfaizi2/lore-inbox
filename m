Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVHUEWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVHUEWg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 00:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVHUEWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 00:22:36 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:16801 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750778AbVHUEWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 00:22:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Date: Sun, 21 Aug 2005 14:22:16 +1000
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <43001E18.8020707@bigpond.net.au> <200508211147.39503.kernel@kolivas.org> <6bffcb0e050820211645c31a7@mail.gmail.com>
In-Reply-To: <6bffcb0e050820211645c31a7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508211422.16850.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Aug 2005 14:16, Michal Piotrowski wrote:
> Hi,
>
> On 8/21/05, Con Kolivas <kernel@kolivas.org> wrote:
> > On Sun, 21 Aug 2005 11:34, Michal Piotrowski wrote:
> > > Hi,
> >
> > Hi
> >
> > > here are kernbench results:
> >
> > Nice to see you using kernbench :)
> >
> > > ./kernbench -M -o 128
> > > [..]
> > > Average Optimal -j 128 Load Run:
> >
> > Was there any reason you chose 128? Optimal usually works out
> > automatically from kernbench to 4x number_cpus. If I recall correctly you
> > have 4 cpus? Not sure what 128 represents.
> >
> > Cheers,
> > Con
>
> No, I just have 1 pentium 4 with ht ;).
>
> Why I chose 128? I just want very high loads. Now I'll try -j192 and
> -j256, but I don't know how does my system survive it.

Well it will survive all right, but eventually get into swap thrash territory 
and that's not a meaningful cpu scheduler benchmark.

Cheers,
Con
