Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbWHOStj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWHOStj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWHOStj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:49:39 -0400
Received: from 1wt.eu ([62.212.114.60]:21263 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S965115AbWHOSti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:49:38 -0400
Date: Tue, 15 Aug 2006 20:45:12 +0200
From: Willy Tarreau <w@1wt.eu>
To: alex@yuriev.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to find a sick router with 2.6.17+ and tcp_window_scaling enabled
Message-ID: <20060815184512.GB6672@1wt.eu>
References: <44E1F0CD.7000003@everytruckjob.com> <20060815180634.GB15957@s2.yuriev.com> <20060815181938.GK8776@1wt.eu> <20060815183300.GC15957@s2.yuriev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815183300.GC15957@s2.yuriev.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 02:33:00PM -0400, alex@yuriev.com wrote:
> On Tue, Aug 15, 2006 at 08:19:39PM +0200, Willy Tarreau wrote:
> 
> > > This is absolutely not correct. Routers forward packets. They do not mangle
> > > the data in them.
> > 
> > Believe it or not, there are a lot of routers nowadays that can do NAT.
> > And even for very basic NAT, you have to recompute the TCP checksum, which
> > means that you mangle data within the packet. Even worse, some of them are
> > able to NAT complex protocols such as FTP and for this, they need to mangle
> > the application payload. OK, this should not be the router's job, but it's
> > often the best placed to do the job, and there is customer demand for this.
> 
> Just because you are using a Linksys/Netgear or god else knows what to
> mangle your packets and call that device a router

That's not what I call a router !

> does not mean that normal service providers have NAT enabled on
> their GSRs and Junipers.

not on the PE, but offen on the CE.

> The issue is not in a router running IOS somewhere. The issue is in the
> broken code/broken driver/broken something on the end-point.

He may very well have an IOS based 1600 or equivalent doing a very dirty NAT.

> Alex

Willy

