Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVGWJEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVGWJEM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 05:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVGWJEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 05:04:12 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:12962 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261310AbVGWJEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 05:04:10 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Giving developers clue how many testers verified certain kernel version
Date: Sat, 23 Jul 2005 19:05:25 +1000
User-Agent: KMail/1.8.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Blaisorblade <blaisorblade@yahoo.it>,
       LKML <linux-kernel@vger.kernel.org>, Andrian Bunk <bunk@stusta.de>,
       "H. Peter Anvin" <hpa@zytor.com>
References: <200507230244.11338.blaisorblade@yahoo.it> <Pine.LNX.4.58.0507222029200.6074@g5.osdl.org> <1122089660.6510.29.camel@mindpipe>
In-Reply-To: <1122089660.6510.29.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507231905.26241.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2005 01:34 pm, Lee Revell wrote:
> On Fri, 2005-07-22 at 20:31 -0700, Linus Torvalds wrote:
> > On Fri, 22 Jul 2005, Lee Revell wrote:
> > > Con's interactivity benchmark looks quite promising for finding
> > > scheduler related interactivity regressions.
> >
> > I doubt that _any_ of the regressions that are user-visible are
> > scheduler-related. They all tend to be disk IO issues (bad scheduling or
> > just plain bad drivers), and then sometimes just VM misbehaviour.
> >
> > People are looking at all these RT patches, when the thing is that most
> > nobody will ever be able to tell the difference between 10us and 1ms
> > latencies unless it causes a skip in audio.
>
> I agree re: the RT patches, but what makes Con's benchmark useful is
> that it also tests interactivity (measuring in msecs vs. usecs) with
> everything running SCHED_NORMAL, which is a much better approximation of
> a desktop load.  And the numbers do go well up into the range where
> people would notice, tens and hundreds of ms.

Indeed, and the purpose of the benchmark is to quantify something rather than 
leave it to subjective feeling. Fortunately if I was to quantify the current 
kernel's situation I would say everything is fine.

Cheers,
Con
