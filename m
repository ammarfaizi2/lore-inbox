Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265231AbTLRQbO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 11:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265236AbTLRQbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 11:31:14 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:26243
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265231AbTLRQbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 11:31:12 -0500
Date: Thu, 18 Dec 2003 11:30:27 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Lennert Buytenhek <buytenh@gnu.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 keyboard not working
In-Reply-To: <20031218150431.GA20543@gnu.org>
Message-ID: <Pine.LNX.4.58.0312181129260.1710@montezuma.fsmlabs.com>
References: <20031218060053.GA645@gnu.org> <Pine.LNX.4.58.0312180230150.1710@montezuma.fsmlabs.com>
 <20031218145434.GA20303@gnu.org> <20031218150431.GA20543@gnu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58.0312181129262.1710@montezuma.fsmlabs.com>
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Dec 2003, Lennert Buytenhek wrote:

> > > > Halfway between having uncompressed the kernel and starting init, the console
> > > > starts to scroll "atkbd.c: Unknown key pressed", mentioning key code 0 (IIRC),
> > > > even though no keys are pressed at all.  After a while, the scrolling stops,
> > > > but the keyboard still doesn't work.  2.4 works fine on the same hardware.
> > > >
> > > > Hardware is an Intel SE7505VB2 board with dual 2.40GHz Xeon processors,
> > > > and a Logitech PS/2 "Internet keyboard."
> > > >
> > > > Ideas?
> > >
> > > May we have a look at your .config?

Thanks Lennert, could you try without CONFIG_HIGHMEM64G, perhaps just
CONFIG_HIGHMEM4G, how much memory in the system? dmesg also would be nice.
