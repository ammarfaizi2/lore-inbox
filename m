Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262607AbSJHAdI>; Mon, 7 Oct 2002 20:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262680AbSJHAdI>; Mon, 7 Oct 2002 20:33:08 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:62955 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262607AbSJHAdH>;
	Mon, 7 Oct 2002 20:33:07 -0400
Date: Mon, 7 Oct 2002 17:38:46 -0700
To: Matthew Wilcox <willy@debian.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Second round of ioctl cleanups
Message-ID: <20021008003846.GA1782@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote :
> - remove the WIRELESS_EXT conditional; always compiling this in costs
>   almost nothing.

	Different people have different opinions about what "almost"
mean (see flame fest about embedeed Linux), so beware ;-)
	The bulk of the stuff that is enabled by WIRELESS_EXT is in
core/wireless.c and core/dev.c. I would find illogical that some part
of the Wireless Extension code are always in (your patch) and some
conditional (core/wireless.c). But it probably doesn't matter...
	Have fun...

	Jean


