Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUBCXO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 18:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUBCXO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 18:14:58 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:12040 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S266175AbUBCXO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 18:14:57 -0500
Date: Wed, 4 Feb 2004 00:13:52 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Flashing keyboard LEDS upon boot.
Message-ID: <20040203231352.GA29363@alpha.home.local>
References: <Pine.LNX.4.53.0402021043450.24519@chaos> <Pine.LNX.4.53.0402021105560.24632@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0402021105560.24632@chaos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dick,

On Mon, Feb 02, 2004 at 11:06:50AM -0500, Richard B. Johnson wrote:
> > Sometimes, when booting Linux-2.3.24 from bzImage, machines
>                                   ^
> Typo                      Linux-2.4.24
> 
> > display "Uncompressing Linux ..., Ok. Booting the kernel."
> > Then the machine just sits there with the keyboard LEDS
> > (Num-Lock, Caps-lock, and Scroll-lock) flashing at about
> > a 1-second interval. It will do this "forever".

Flashing leds indicate a kernel panic on recent kernels (was in -ac for
a while).

> > Can anybody tell me what it has found "wrong" that prevents
> > it from continuing the boot? A whole bunch of new Dell Computers
> > display this problem. The second boot will always work, but
> > the first cold-start boot will often result in this problem.

Hmmm. perhaps ACPI or a broken driver ?

Cheers,
Willy

