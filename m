Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261901AbSIYDpG>; Tue, 24 Sep 2002 23:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261902AbSIYDpG>; Tue, 24 Sep 2002 23:45:06 -0400
Received: from quechua.inka.de ([212.227.14.2]:28492 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S261901AbSIYDpE>;
	Tue, 24 Sep 2002 23:45:04 -0400
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
In-Reply-To: <Pine.LNX.4.44L.0209242223040.22735-100000@imladris.surriel.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17u3Bq-0005Zl-00@sites.inka.de>
Date: Wed, 25 Sep 2002 05:50:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44L.0209242223040.22735-100000@imladris.surriel.com> you wrote:
> If it's IO bound, it's quite possible the problem is the disk
> elevator and Andrew Morton's read-latency2 patch might help
> somewhat (if the system is heavy on both reads and writes).

hmm.. it does not look so from the posted stats, or do you think so? 10%
system time and 0% idle.

> It would make sense to study the output of top and vmstat for
> a few hours to identify exactly what the problem is

yes, I think so.

Greetings
Bernd
