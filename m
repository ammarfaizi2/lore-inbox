Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318872AbSHRH1k>; Sun, 18 Aug 2002 03:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318873AbSHRH1k>; Sun, 18 Aug 2002 03:27:40 -0400
Received: from quechua.inka.de ([212.227.14.2]:8004 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S318872AbSHRH1k>;
	Sun, 18 Aug 2002 03:27:40 -0400
From: Bernd Eckenfels <ecki-news2002-08@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <Pine.LNX.4.44.0208172104420.21581-100000@twinlark.arctic.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17gKXF-0008Ax-00@sites.inka.de>
Date: Sun, 18 Aug 2002 09:31:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet <dean-list-linux-kernel@arctic.org> wrote:
> many southbridges come with audio these days ... isn't it possible to get
> randomness off the adc even without anything connected to it?

they also come with RNGs.

A question: what is the denger of the network entropy? is it, that one is a
fraid that snooping could gather knowledge about random source, or is it
more along the line that one fears that specially deviced packages can feed
manufactured, and therefore not randmom bits?

In the first case, how big would be the hardware proccessing variance for an
interrupt be? Is it realy predictable from sniffing the network how that
will result in interrupts?

How can softinterrupts help here?

Greetings
Bernd
