Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSGGTFU>; Sun, 7 Jul 2002 15:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316477AbSGGTFT>; Sun, 7 Jul 2002 15:05:19 -0400
Received: from quechua.inka.de ([212.227.14.2]:49750 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S316465AbSGGTFS>;
	Sun, 7 Jul 2002 15:05:18 -0400
From: Bernd Eckenfels <ecki-news2002-06@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] batch/idle priority scheduling, SCHED_BATCH
In-Reply-To: <20020707124613.GE30476@unthought.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17RHO2-0003tV-00@sites.inka.de>
Date: Sun, 7 Jul 2002 21:07:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020707124613.GE30476@unthought.net> you wrote:
> Idle-time is what you pay for but do not get  ;)   Having CPU hogs
> running is a nice way of getting the last penny out of the investment,
> but I have many boxes where I don't do it, simply because it would
> render the load statistics useless.

And of course it needs a bit more power and produces much more temperature
(and therefore noise).

BTW: even an batch prio will load the system more than an idle process. The
cache is dirty, the disk has a longer work queue, RSS is used up by that
programs. So for a slow system you have to expect impact.

Greetings
Bernd
