Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTEWGhE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 02:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263657AbTEWGhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 02:37:04 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:35338 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263646AbTEWGhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 02:37:03 -0400
Date: Fri, 23 May 2003 08:30:37 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>
cc: Stian Jordet <liste@jordet.nu>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: irtty_sir cannot be unloaded
In-Reply-To: <20030523011349.GA12195@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0305230822090.14825-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 May 2003, Jean Tourrilhes wrote:

> > Well, this got rid of the warning :) But actually when I stop irattach
> > (using Debian's init-script (/etc/init.d/irda stop)) my computer
> > freezes. This works (of course) fine with 2.4.21-rc2. I thought the
> > problem was the module unloading, but it seems to be something with
> > irattach instead. Sorry about that.
> 
> 	Disable HotPlug in your kernel and recompile. Various network
> people have been notified of this bug, but this is not an easy one.

Seems the thread died...

> > irlap_change_speed(), setting speed to 9600
> > sirdev_open - done, speed = 0
> > sirdev_schedule_request - state=0x0700 / param=9600
> > sirdev_schedule_request - down
> > irda_config_fsm - up
> 
> 	Yeah, Martin should increase the debug level.

This and a few other things from the list which I've sent to you is done 
in my local codebase, but needs some testing over the weekend. So you'll 
see patches on monday. I guess I'll make them against what you've sent to 
Jeff despite it may need some more time until this appears in bk - Ok?

Martin

