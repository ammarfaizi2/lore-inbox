Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264782AbUFTA2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbUFTA2y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 20:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264788AbUFTA2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 20:28:54 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:42725 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264782AbUFTA2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 20:28:53 -0400
Date: Sat, 19 Jun 2004 20:30:56 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>, florin@iucha.net,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Len Brown <len.brown@intel.com>
Subject: Re: linux-2.6.7-bk2 runs faster than linux-2.6.7 ;)
In-Reply-To: <200406200237.54067.dominik.karall@gmx.net>
Message-ID: <Pine.LNX.4.58.0406192029380.2228@montezuma.fsmlabs.com>
References: <20040619210714.GD3243@iucha.net> <200406200207.16399.dominik.karall@gmx.net>
 <20040619162322.1d15c2dd.akpm@osdl.org> <200406200237.54067.dominik.karall@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004, Dominik Karall wrote:

> On Sunday 20 June 2004 01:23, Andrew Morton wrote:
> > Dominik Karall <dominik.karall@gmx.net> wrote:
> > > > dmesg and .config, please.
> > >
> > >  attached
> >
> > The dmesg output is incomplete.  You'll need to use `dmesg -s 1000000' to
> > get all of it.
> >
> > I wish that would get fixed actually.  Seems a bit silly, and current
> > kernels permit querying of the ringbuffer size.
> 'dmesg -s 1000000' output attached.

Try booting with 'acpi=off'

IRQ to pin mappings:
IRQ0 -> 0:0-> 0:2
