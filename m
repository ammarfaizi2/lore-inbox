Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUDYHKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUDYHKy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 03:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbUDYHKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 03:10:54 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:5070 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262060AbUDYHKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 03:10:53 -0400
Date: Sun, 25 Apr 2004 03:10:29 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alexey Mahotkin <alexm@w-m.ru>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: flooded by "CPU#0: Running in modulated clock mode"
In-Reply-To: <20040424110730.GB2595@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.58.0404250309080.3414@montezuma.fsmlabs.com>
References: <8765btmd9n.fsf@dim.w-m.ru> <Pine.LNX.4.58.0404211355220.2250@montezuma.fsmlabs.com>
 <87y8opkxyo.fsf@dim.w-m.ru> <Pine.LNX.4.58.0404211411390.2250@montezuma.fsmlabs.com>
 <20040424110730.GB2595@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Apr 2004, Pavel Machek wrote:

> Hi!
>
>
> > If i recall correctly it's hardware set, i'm not sure if BIOSes can modify
> > that these days. One thing you may want to note is that in the modulated
> > state the processor doesn't process interrupts and runs at a 50% clock
>
> No interrupts? That would mean almost dead machine.
> Are you sure?

Yep, it's normally 50% modulation for 1ms or until the temperature drops
below threshold, whichever comes first with interrupts remaining pending.

