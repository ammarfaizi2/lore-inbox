Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264795AbSKJKIQ>; Sun, 10 Nov 2002 05:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264796AbSKJKIQ>; Sun, 10 Nov 2002 05:08:16 -0500
Received: from 184.80-203-35.nextgentel.com ([80.203.35.184]:31586 "EHLO
	sevilla.gnome.no") by vger.kernel.org with ESMTP id <S264795AbSKJKIP> convert rfc822-to-8bit;
	Sun, 10 Nov 2002 05:08:15 -0500
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
From: Kjartan Maraas <kmaraas@online.no>
To: Jens Axboe <axboe@suse.de>
Cc: Con Kolivas <conman@kolivas.net>, Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <20021109135446.GA2551@suse.de>
References: <200211091300.32127.conman@kolivas.net>
	 <200211091612.08718.conman@kolivas.net> <20021109112135.GB31134@suse.de>
	 <200211100009.55844.conman@kolivas.net>  <20021109135446.GA2551@suse.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1036923167.2538.7.camel@sevilla.gnome.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 10 Nov 2002 11:12:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lør, 2002-11-09 kl. 14:54 skrev Jens Axboe:

[SNIP]

> The default is 2048. How long does the io_load test take, or rather how

The default on my RH system with the latest errata kernel is as follows:

[root@sevilla kmaraas]# elvtune /dev/hda

/dev/hda elevator ID		0
	read_latency:		8192
	write_latency:		16384
	max_bomb_segments:	6

[root@sevilla kmaraas]# uname -a
Linux sevilla.gnome.no 2.4.18-17.7.x #1 Tue Oct 8 13:33:14 EDT 2002 i686
unknown
[root@sevilla kmaraas]# 

Is this worth changing to lower values then? They seem to be an awful
lot higher than the values mentioned below here.

> many tests are appropriate to do? To get a good picture of how it looks
> you should probably try: 0, 8, 16, 64, 128, 512. Once you get some of
> these results, it will be easier to determine which area(s) would be
> most interesting to further explore.
> 
> There's also the write passover, I don't think it will have much impact
> on this test though.

Cheers
Kjartan

