Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbUDEXHj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbUDEXHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:07:39 -0400
Received: from waste.org ([209.173.204.2]:17566 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262399AbUDEXHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 19:07:37 -0400
Date: Mon, 5 Apr 2004 18:07:23 -0500
From: Matt Mackall <mpm@selenic.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] Drop exported symbols list if !modules
Message-ID: <20040405230723.GK6248@waste.org>
References: <20040405205539.GG6248@waste.org> <1081205099.15272.7.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081205099.15272.7.camel@bach>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 08:45:01AM +1000, Rusty Russell wrote:
> On Tue, 2004-04-06 at 06:55, Matt Mackall wrote:
> > Drop ksyms if we've built without module support
> > 
> > From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
> > Subject: Re: 2.6.1-rc1-tiny2
> 
> Other than saving a little compile time, does this actually do anything?
> 
> I'm not against it, I just don't think I see the point.

Well it obviously saves memory and image size too; I'm in the process
of merging bits from my -tiny tree. As bloat has a way of being
well-distributed across the code base, it's going to take many small
trimmings to cut it back. Most of the 150 or so patches I've got now
save between 1 and 8k. Doesn't sound like much, but it adds up.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
