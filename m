Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSJUMQl>; Mon, 21 Oct 2002 08:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261350AbSJUMQl>; Mon, 21 Oct 2002 08:16:41 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:180 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261349AbSJUMQk>; Mon, 21 Oct 2002 08:16:40 -0400
Subject: Re: 2.6: Shortlist of Missing Features
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Roman Zippel <zippel@linux-m68k.org>, riel@conectiva.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       akpm@zip.com.au, davej@suse.de, davem@redhat.com,
       Guillaume Boissiere <boissiere@adiglobal.com>, mingo@redhat.com
In-Reply-To: <20021021135137.2801edd2.rusty@rustcorp.com.au>
References: <Pine.LNX.4.44L.0210192357430.22993-100000@imladris.surriel.com>
	<Pine.LNX.4.44.0210201444460.8911-100000@serv> 
	<20021021135137.2801edd2.rusty@rustcorp.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 13:38:17 +0100
Message-Id: <1035203897.27259.76.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 04:51, Rusty Russell wrote: 
> - Device Mapper (lvm2)	(Alasdair Kergon, Patrick Caulfield, Joe Thornber)

This is in my tree

> - New config system (Roman Zippel)
> - In-kernel module loader (Rusty Russell)
> - Unified boot/parameter support (Rusty Russell)
> - Hotplug CPU removal (Rusty Russell)

I guess much of this is now early 2.7.x stuff. Does mean more time to
get it really clean and to figure all the hotplug cpu issues before they
hit the official Linus tree

The big one missing is 32bit dev_t. Thats the killer item we have left.
The rest is mostly driver work, and some forward porting of major 2.4
features not yet in 2.5.

I'd love the split console stuff if it was ready but its not vital, and
I really want to get ucLinux merged or mostly merged

