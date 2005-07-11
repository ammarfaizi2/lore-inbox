Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVGKOKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVGKOKC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVGKOHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:07:40 -0400
Received: from fsmlabs.com ([168.103.115.128]:4574 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261738AbVGKOE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:04:56 -0400
Date: Mon, 11 Jul 2005 08:09:44 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] i386: Per node IDT
In-Reply-To: <1121054565.3177.2.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0507110804210.16055@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0507101617240.16055@montezuma.fsmlabs.com.suse.lists.linux.kernel>
  <p73eka614t7.fsf@verdi.suse.de> <1121054565.3177.2.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2005, Arjan van de Ven wrote:

> On Mon, 2005-07-11 at 03:59 +0200, Andi Kleen wrote:
> > Why per node? Why not go the whole way and make it per CPU?
> 
> Agreed, for two reasons even
> 1) Per cpu allows for even more devices and cache locality
> 2) While few people have a NUMA system, many have an SMP system so you
> get a lot more testing.

Agreed, the first version was a per cpu one simply so that i could test it 
on a normal SMP system. Andi seems to be of the same opinion, what do you 
think of the hotplug cpu case (explained in previous email)?

Thanks Arjan,
	Zwane

