Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbSKRUp4>; Mon, 18 Nov 2002 15:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264767AbSKRUp4>; Mon, 18 Nov 2002 15:45:56 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60173 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264697AbSKRUpz>; Mon, 18 Nov 2002 15:45:55 -0500
Date: Mon, 18 Nov 2002 15:51:58 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Filipau, Ihar" <ifilipau@sussdd.de>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: useless image of hdd: how to make it useful?
In-Reply-To: <7A5D4FEED80CD61192F2001083FC1CF906505A@CHARLY>
Message-ID: <Pine.LNX.3.96.1021118154916.27535B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Filipau, Ihar wrote:

> Hello All!
> 
> 	[ please CC me - I'm not subscribed to the list. ]
> 
> 	This question was in my mind for couple of years.
> 	But after all I decided to ask it. (Better later - than never ;-))
> 
> 	Little prehistory: I had on my old home PC two hard drives - hda &
> hdc.
> 		hda was big and new, while hdc was old, small and sure it
> contained 
> 		a lot of old useful stuff. So I decided to upgrade my very
> valuable hdc.
> 		And sure, as simple novice in hdd upgrades, I've made smth
> like:
> 			# dd if=/dev/hdc of=/root/hdc_img
> 		And right after upgrade - I got small rebate in exchange for
> my old hdd - 
> 		I understood my problem.
> 
> 	I do not know the way to mount partition table!
> 	it's possible with loop device to mount partition - but how to mount
> whole 
> 	hdd (with its own partition table) to have access to single
> partition inside???

I believe that you can do it with a network block device, at least in
theory. I lack the inclination to try it, but I'd love to hear that this
suggestion was useful.

You can probably do it with loopback mount and offset, but if I had the
problem I'd try NBD just to see if you really can do it!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

