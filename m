Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbVAQFes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVAQFes (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 00:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbVAQFes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 00:34:48 -0500
Received: from fsmlabs.com ([168.103.115.128]:60130 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262696AbVAQFeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 00:34:46 -0500
Date: Sun, 16 Jan 2005 22:35:05 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>, Linux PPC64 <linuxppc64-dev@ozlabs.org>,
       Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PPC64 pmac hotplug cpu
In-Reply-To: <1105937266.4534.0.camel@gaston>
Message-ID: <Pine.LNX.4.61.0501162234390.3010@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0501122341410.23299@montezuma.fsmlabs.com> 
 <1105827794.27410.82.camel@gaston>  <Pine.LNX.4.61.0501162129380.3010@montezuma.fsmlabs.com>
 <1105937266.4534.0.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2005, Benjamin Herrenschmidt wrote:

> On Sun, 2005-01-16 at 21:37 -0700, Zwane Mwaikambo wrote:
> > Hello Ben,
> > 
> > On Sun, 16 Jan 2005, Benjamin Herrenschmidt wrote:
> > 
> > > Looks good, but you could do even better :) I still want to look at the
> > > proper mecanism to flush the CPU cache on 970, but the idea here is to
> > > flush it, and put the CPU into a NAP loop (the 970 has no SLEEP mode)
> > > with the caches clean and MSR:EE off. We can later get it back with a
> > > soft reset.
> > 
> > Thanks for the suggestions! I'll work on getting something together.
> 
> Well.. the cache flush part requires some not-really-documentd stuff on
> the 970, but I'll try to come up with something.

I was waiting for you to say that ;)

Thanks,
	Zwane

