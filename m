Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbWHOSmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWHOSmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbWHOSmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:42:05 -0400
Received: from s2.yuriev.com ([69.31.8.140]:51124 "HELO s2.yuriev.com")
	by vger.kernel.org with SMTP id S965075AbWHOSmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:42:01 -0400
Date: Tue, 15 Aug 2006 14:33:00 -0400
From: alex@yuriev.com
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to find a sick router with 2.6.17+ and tcp_window_scaling enabled
Message-ID: <20060815183300.GC15957@s2.yuriev.com>
References: <44E1F0CD.7000003@everytruckjob.com> <20060815180634.GB15957@s2.yuriev.com> <20060815181938.GK8776@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815181938.GK8776@1wt.eu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 08:19:39PM +0200, Willy Tarreau wrote:

> > This is absolutely not correct. Routers forward packets. They do not mangle
> > the data in them.
> 
> Believe it or not, there are a lot of routers nowadays that can do NAT.
> And even for very basic NAT, you have to recompute the TCP checksum, which
> means that you mangle data within the packet. Even worse, some of them are
> able to NAT complex protocols such as FTP and for this, they need to mangle
> the application payload. OK, this should not be the router's job, but it's
> often the best placed to do the job, and there is customer demand for this.

Just because you are using a Linksys/Netgear or god else knows what to
mangle your packets and call that device a router does not mean that normal
service providers have NAT enabled on their GSRs and Junipers.

The issue is not in a router running IOS somewhere. The issue is in the
broken code/broken driver/broken something on the end-point.

Alex
