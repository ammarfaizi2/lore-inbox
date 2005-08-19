Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbVHSDvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbVHSDvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 23:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVHSDvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 23:51:35 -0400
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:59874 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932549AbVHSDve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 23:51:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Date: Fri, 19 Aug 2005 13:41:24 +1000
User-Agent: KMail/1.8.2
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       LKML <linux-kernel@vger.kernel.org>
References: <43001E18.8020707@bigpond.net.au> <6bffcb0e050818200936bad1d3@mail.gmail.com> <1124422128.25424.7.camel@mindpipe>
In-Reply-To: <1124422128.25424.7.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508191341.24821.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2005 01:28 pm, Lee Revell wrote:
> On Fri, 2005-08-19 at 05:09 +0200, Michal Piotrowski wrote:
> > Hi,
> > here are interbench v0.29 resoults:
>
> The X test under simulated "Compile" load looks most interesting.
>
> Most of the schedulers do quite poorly on this test - only Zaphod with
> default max_ia_bonus and max_tpt_bonus manages to deliver under 100ms
> max latency.  As expected with interactivity bonus disabled it performs
> horribly.

The compile load is not a real compile load; it is an extreme exaggeration of 
what happens during a compile and this is done to increase the sensitivity of 
this test. It is _not_ worth trying to get a perfect score in this.

> I'd like to see some results with X reniced to -10.  Despite what the
> 2.6 release notes say, this still seems to make a difference.

Well of course it helps X - but then any X load totally fscks up audio on 
mainline and staircase which is why it's recommended not to renice it.

Cheers,
Con
