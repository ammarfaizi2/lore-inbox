Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268786AbUHTWhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268786AbUHTWhz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 18:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268787AbUHTWhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 18:37:55 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:60138 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268786AbUHTWhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 18:37:54 -0400
Date: Fri, 20 Aug 2004 18:42:05 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: John Levon <levon@movementarian.org>
Cc: Corey Minyard <minyard@acm.org>, Mikael Pettersson <mikpe@csd.uu.se>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Patch to 2.6.8.1-mm2 to allow multiple NMI handlers to be
 registered
In-Reply-To: <20040819163124.GA81535@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.58.0408201840520.27390@montezuma.fsmlabs.com>
References: <4124BACB.30100@acm.org> <16676.51035.924323.992044@alkaid.it.uu.se>
 <4124D25C.20703@acm.org> <20040819163124.GA81535@compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004, John Levon wrote:

> On Thu, Aug 19, 2004 at 11:16:28AM -0500, Corey Minyard wrote:
>
> > >Please use rdpmc() instead of rdmsr() when reading counter registers.
> > >Ditto in the other places.
> > >(I know oprofile doesn't, but that's no excuse.)
>
> I actually have no idea why we don't use rdpmc().

If i recall, not all the performance counters were accessible via rdpmc
and being slower.
