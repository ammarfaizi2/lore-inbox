Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316686AbSGHAxo>; Sun, 7 Jul 2002 20:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316693AbSGHAxn>; Sun, 7 Jul 2002 20:53:43 -0400
Received: from quechua.inka.de ([212.227.14.2]:26996 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S316686AbSGHAxn>;
	Sun, 7 Jul 2002 20:53:43 -0400
From: Bernd Eckenfels <ecki-news2002-06@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: BKL removal
In-Reply-To: <20020707222417.GC18298@kroah.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17RMpC-0006c8-00@sites.inka.de>
Date: Mon, 8 Jul 2002 02:56:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020707222417.GC18298@kroah.com> you wrote:
> Either way, you get my same response, "Why?"  Again, as someone stated,
> where in the USB code is the BKL used that affects performance in any
> real life situations?

AFAIK the BKL in a not often used path can still be hold too long and affect
latecy. I think the most recent low latency patches find a few instances. I
am not completly shure if that is only about interrupts, or if it applies to
the BKL, too.

Greetings
Bernd
