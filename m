Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUBDORR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 09:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUBDORR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 09:17:17 -0500
Received: from chaos.analogic.com ([204.178.40.224]:27012 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261909AbUBDORP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 09:17:15 -0500
Date: Wed, 4 Feb 2004 09:19:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Willy Tarreau <willy@w.ods.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Flashing keyboard LEDS upon boot.
In-Reply-To: <20040203231352.GA29363@alpha.home.local>
Message-ID: <Pine.LNX.4.53.0402040912480.4254@chaos>
References: <Pine.LNX.4.53.0402021043450.24519@chaos> <Pine.LNX.4.53.0402021105560.24632@chaos>
 <20040203231352.GA29363@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Feb 2004, Willy Tarreau wrote:

> Hi Dick,
>
> On Mon, Feb 02, 2004 at 11:06:50AM -0500, Richard B. Johnson wrote:
> > > Sometimes, when booting Linux-2.3.24 from bzImage, machines
> >                                   ^
> > Typo                      Linux-2.4.24
> >
> > > display "Uncompressing Linux ..., Ok. Booting the kernel."
> > > Then the machine just sits there with the keyboard LEDS
> > > (Num-Lock, Caps-lock, and Scroll-lock) flashing at about
> > > a 1-second interval. It will do this "forever".
>
> Flashing leds indicate a kernel panic on recent kernels (was in -ac for
> a while).
>
> > > Can anybody tell me what it has found "wrong" that prevents
> > > it from continuing the boot? A whole bunch of new Dell Computers
> > > display this problem. The second boot will always work, but
> > > the first cold-start boot will often result in this problem.
>
> Hmmm. perhaps ACPI or a broken driver ?
>
> Cheers,
> Willy
>

Well I modified the kernel to write 0 to the printer port
when it starts uncompressing the RAM disk and subsequent
numbers after. It never gets beyond 1, which means it crashed
immediately after or during the printing of "OK. Booting the
kernel"

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


