Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290165AbSAQTQn>; Thu, 17 Jan 2002 14:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290167AbSAQTQ0>; Thu, 17 Jan 2002 14:16:26 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:63500 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290165AbSAQTQO>; Thu, 17 Jan 2002 14:16:14 -0500
Date: Thu, 17 Jan 2002 14:15:53 -0500
Message-Id: <200201171915.OAA02742@gatekeeper.tmr.com>
To: davem@redhat.com
Subject: Re: hires timestamps for netif_rx()
Newsgroups: mail.linux-kernel
In-Reply-To: <20020116.211251.35505694.davem@redhat.com>
In-Reply-To: <Pine.GSO.4.40.0201161827510.28457-100000@apogee.whack.org>
Organization: TMR Associates, Schenectady NY
Cc: linux-kernel@vger.kernel.org
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020116.211251.35505694.davem@redhat.com> you write:
|    From: Wilson Yeung <wilson@whack.org>
|    Date: Wed, 16 Jan 2002 18:45:02 -0800 (PST)
| 
|    Notice that all the timestamps are the same, which led me to believe that
|    xtime was being gotten directly.
|    
| This is what happens only if your CPU lacks a timestamp counter
| (TSC on x86).  What kind of CPU are you performing this experiment
| on?

In the part of the message you snipped:
> That's interesting, because when I call do_gettimeofday() instead of
> get_fast_time(), I get different kinds of results that imply that these
> are not equivalent.  I'm running the kernel on a PIII.

I would think that was short for "Pentium-III" which should have TSC.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
