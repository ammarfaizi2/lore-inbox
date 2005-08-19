Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbVHSD2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbVHSD2v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 23:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbVHSD2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 23:28:51 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:1232 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750977AbVHSD2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 23:28:51 -0400
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4
	for 2.6.12 and 2.6.13-rc6
From: Lee Revell <rlrevell@joe-job.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Con Kolivas <kernel@kolivas.org>, Peter Williams <pwil3058@bigpond.net.au>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <6bffcb0e050818200936bad1d3@mail.gmail.com>
References: <43001E18.8020707@bigpond.net.au>
	 <200508180916.08454.kernel@kolivas.org> <4303CCB9.6000403@bigpond.net.au>
	 <200508180945.50185.kernel@kolivas.org>
	 <6bffcb0e050818200936bad1d3@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 23:28:47 -0400
Message-Id: <1124422128.25424.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-19 at 05:09 +0200, Michal Piotrowski wrote:
> Hi,
> here are interbench v0.29 resoults:

The X test under simulated "Compile" load looks most interesting.

Most of the schedulers do quite poorly on this test - only Zaphod with
default max_ia_bonus and max_tpt_bonus manages to deliver under 100ms
max latency.  As expected with interactivity bonus disabled it performs
horribly.

I'd like to see some results with X reniced to -10.  Despite what the
2.6 release notes say, this still seems to make a difference.

Lee

