Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263901AbTJFAAh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 20:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTJFAAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 20:00:37 -0400
Received: from karnickel.franken.de ([193.141.110.11]:44811 "EHLO
	karnickel.franken.de") by vger.kernel.org with ESMTP
	id S263901AbTJFAAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 20:00:36 -0400
Date: Mon, 6 Oct 2003 01:51:49 +0200
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs one user DoS?
Message-ID: <20031005235149.GA3993@debian.franken.de>
References: <20031004120625.GA41175@colocall.net> <3F7EF082.3020702@namesys.com> <3F804234.9070606@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F804234.9070606@g-house.de>
User-Agent: Mutt/1.5.4i
From: erik@debian.franken.de (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05, 2003 at 06:09:24PM +0200, Christian Kujau wrote:
> Hans Reiser schrieb:
> >>I have found such strange thing:
> >>
> >>pseudo@avalon at 14:04:00  ~> dd if=/dev/zero of=file bs=1 count=0 
> >>seek=1000000000000
> >>
> >>After that my Intel Celeron 800 MHz/384M RAM 60G/Seagate U6 under
> >>Linux-2.4.22-grsec on reiserfs was utilized 100% for more than 2 hours.
> >>dd process can't be killed.
> >>
> >>Is this my flow or real bug?
> >>
> >it is fixed in reiser4.  linux has a lot of DOS vulerabilities to logged 
> >in users, mostly due to the ability to consume all of some resource or 
> >another.  forgive me for not discussing them publicly.;-)
> 
> perhaps "ulimit" could help here.

Really? If I got a process which is unkillable, how can the kernel kill
this process if it runs out of cpu-time?
