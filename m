Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTKQR3U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 12:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbTKQR3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 12:29:20 -0500
Received: from continuum.cm.nu ([216.113.193.225]:27797 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id S263600AbTKQR3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 12:29:19 -0500
Date: Mon, 17 Nov 2003 09:29:18 -0800
From: Shane Wegner <shane-keyword-kernel.a35a91@cm.nu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 crash on Intel SDS2
Message-ID: <20031117172918.GA15649@cm.nu>
References: <20031116220200.GA1446@cm.nu> <Pine.LNX.4.44.0311170928330.1698-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311170928330.1698-100000@logos.cnet>
X-No-Archive: yes
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 09:29:10AM -0200, Marcelo Tosatti wrote:
> > # 03/09/04	laforge@netfilter.org	1.1063.41.4
> > # [NETFILTER]: NAT range calculation fix.
> > # 
> > # This patch fixes a logic bug in NAT range calculations, which also
> > # causes a large slowdown when ICMP floods go through NAT.
> > # 
> > # Author: Karlis Piesenieks
> > Reversing that change has thus far fixed things over here
> > but time will tell.  Is there any possible way that that
> > particular change is somehow not smp safe?
> 
> That change is broken, its known to break other setups.
> 
> It has been reverted in the BK tree.

I can now pretty much confirm that was the cause.  I have a
19 hour uptime with pre4.  Thanks for all your assistance.

Shane
