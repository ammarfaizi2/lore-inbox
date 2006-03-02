Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWCBMVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWCBMVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 07:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWCBMVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 07:21:40 -0500
Received: from witte.sonytel.be ([80.88.33.193]:48366 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751217AbWCBMVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 07:21:40 -0500
Date: Thu, 2 Mar 2006 13:21:32 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: jensmh@gmx.de, Dave Jones <davej@redhat.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc5 'lost' cpu
In-Reply-To: <200603020505.13108.jensmh@gmx.de>
Message-ID: <Pine.LNX.4.62.0603021318470.22852@pademelon.sonytel.be>
References: <200603020505.13108.jensmh@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2006 jensmh@gmx.de wrote:
> This is a dual xeon system with hyper threading enabled, so there should
> be 4 cpus
> 
> jm@voyager ~ $ ll /proc/acpi/processor/
> total 0
> dr-xr-xr-x  2 root root 0 Mar  2 05:01 CPU0
> dr-xr-xr-x  2 root root 0 Mar  2 05:01 CPU1
> dr-xr-xr-x  2 root root 0 Mar  2 05:01 CPU3

Hmm, perhaps ACPI teleported it (and converted it to an AMD64) into Dave Jones'
machine? (see the other thread about the `extra' CPU ;-)

Interesting...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
