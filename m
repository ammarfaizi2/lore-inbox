Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbTEWGSe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 02:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263657AbTEWGSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 02:18:34 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:30226 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263654AbTEWGSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 02:18:32 -0400
Date: Fri, 23 May 2003 08:38:14 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Stian Jordet <liste@jordet.nu>
cc: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: irtty_sir cannot be unloaded
In-Reply-To: <1053654253.668.1.camel@chevrolet.hybel>
Message-ID: <Pine.LNX.4.44.0305230830490.14825-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 May 2003, Stian Jordet wrote:

> > 	Disable HotPlug in your kernel and recompile. Various network
> > people have been notified of this bug, but this is not an easy one.
> 
> You were right, this was the problem. Then I just have to choose what I
> need the most; irda or pcmcia :)

I bet pcmcia works without hotplug ;-)

IMHO the worst thing that might happen without hotplug would be one has to 
modprobe some drivers for CardBus cards by hand. But maybe I'm missing 
something because I'm not using hotplug...

Anyway, I really hope the network-hotplug deadlock issue gets resolved 
before 2.6.0 or we'll see quite a number of such reports then...

Martin

