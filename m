Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281818AbRLBVYh>; Sun, 2 Dec 2001 16:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281797AbRLBVY2>; Sun, 2 Dec 2001 16:24:28 -0500
Received: from [194.168.151.1] ([194.168.151.1]:21252 "EHLO the-village.bc.nu")
	by vger.kernel.org with ESMTP id <S281809AbRLBVYL>;
	Sun, 2 Dec 2001 16:24:11 -0500
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 2 Dec 2001 21:32:39 +0000 (GMT)
Cc: lm@bitmover.com (Larry McVoy),
        vonbrand@sleipnir.valparaiso.cl (Horst von Brand),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <m1u1v9wdd8.fsf@frodo.biederman.org> from "Eric W. Biederman" at Dec 02, 2001 01:55:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16AeE3-0004ct-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The next incremental step is to get some good distributed and parallel
> file systems.  So you can share one filesystem across the cluster.
> And there is some work going on in those areas.  luster, gfs,
> intermezzo.

gfs went proprietary - you want opengfs

A lot of good work on the rest of that multi-node clustering is going on
already - take a look at the compaq open source site.

cccluster is more for numa boxes, but it needs the management and SSI views
that the compaq stuff offers simply because most programmers won't program
for a cccluster or manage one.

Alan
