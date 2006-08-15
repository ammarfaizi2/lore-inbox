Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030386AbWHORas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbWHORas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWHORas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:30:48 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:1287
	"HELO linuxace.com") by vger.kernel.org with SMTP id S1030386AbWHORar
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:30:47 -0400
Date: Tue, 15 Aug 2006 10:30:46 -0700
From: Phil Oester <kernel@linuxace.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Reidenbach <m.reidenbach@everytruckjob.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How to find a sick router with 2.6.17+ and tcp_window_scaling enabled
Message-ID: <20060815173046.GA2034@linuxace.com>
References: <44E1F0CD.7000003@everytruckjob.com> <1155661308.24077.297.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155661308.24077.297.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 06:01:47PM +0100, Alan Cox wrote:
> Ar Maw, 2006-08-15 am 11:05 -0500, ysgrifennodd Mark Reidenbach:
> > Does anyone have a way to find the broken router if you are not running 
> > the networks involved?  
> 
> You are almost certainly looking for a broken/crap NAT box, firewall or
> similar product. Routers that are just being routers don't touch the TCP
> layer so even if they are broken/crap/ancient they won't do any harm to
> it.
> 
> The usual offenders are cheap NAT boxes and badly designed load
> balancers. They may not even show up in a trace but you should expect
> them to be at one end or the other, unless your ISP is providing you
> with NATted addresses or some kind of managed security service.

Certain versions of BSD ipfilter are also broken.  Try some of Apple's
websites for examples.  

Is the destination box BSD or behind a BSD firewall?

Phil
