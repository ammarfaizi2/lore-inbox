Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267390AbRGYXVa>; Wed, 25 Jul 2001 19:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267405AbRGYXVU>; Wed, 25 Jul 2001 19:21:20 -0400
Received: from quechua.inka.de ([212.227.14.2]:18492 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S267390AbRGYXVC>;
	Wed, 25 Jul 2001 19:21:02 -0400
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: route problem.. kernel/driver ?
In-Reply-To: <Pine.GSO.4.33.0107251605050.18465-100000@noella.mindsec.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E15PXxl-0001sB-00@sites.inka.de>
Date: Thu, 26 Jul 2001 01:21:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <Pine.GSO.4.33.0107251605050.18465-100000@noella.mindsec.com> you wrote:
> After doing the same research I've been doing the past week or so.. I'm
> coming back to the conclusion that you "can't" have two default routes.

> Which doesn't explain why it works at all.

You can have two default routes. In one case you have different metrics, then
only the one with the smaller metric is used. This is good for situations
where the better route may get dropped (link down).

Yu can have also 2 default routes to the same destination, it is called equal
cost multi route and a kernel option, used for load balancing.

any other configurations are great problem.

It is related to the route cache, why it did worked.

route -C

Greetings
Bernd
