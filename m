Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVHFBW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVHFBW1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 21:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVHFBW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 21:22:26 -0400
Received: from waste.org ([216.27.176.166]:64670 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262199AbVHFBWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 21:22:24 -0400
Date: Fri, 5 Aug 2005 18:22:19 -0700
From: Matt Mackall <mpm@selenic.com>
To: Andi Kleen <ak@suse.de>
Cc: John B?ckstrand <sandos@home.se>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: lockups with netconsole on e1000 on media insertion
Message-ID: <20050806012219.GZ8074@waste.org>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel> <p73ek987gjw.fsf@bragg.suse.de> <20050805201215.GG7425@waste.org> <20050805215650.GH8266@wotan.suse.de> <20050805232015.GX8074@waste.org> <20050805235122.GI8266@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805235122.GI8266@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2005 at 01:51:22AM +0200, Andi Kleen wrote:
> > But why are we in a hurry to dump the backlog on the floor? Why are we
> > worrying about the performance of netpoll without the cable plugged in
> > at all? We shouldn't be optimizing the data loss case.
> 
> Because a system shouldn't stall for minutes (or forever like right now) 
> at boot just because the network cable isn't plugged in.

Using netconsole without a network cable could well be classified as a
serious configuration error. NFS also is a bit sluggish without a
network cable.

I've already agreed that forever is a problem. Can we work towards
agreeing on a non-trivial timeout, please?

-- 
Mathematics is the supreme nostalgia of our time.
