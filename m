Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbUKIPJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbUKIPJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 10:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbUKIPJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 10:09:26 -0500
Received: from witte.sonytel.be ([80.88.33.193]:20892 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261553AbUKIPJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 10:09:19 -0500
Date: Tue, 9 Nov 2004 16:09:03 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: dhowells@redhat.com
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       davidm@snapgear.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       uClinux list <uclinux-dev@uclinux.org>
Subject: Re: [PATCH 7/20] FRV: Fujitsu FR-V CPU arch implementation part 5
In-Reply-To: <200411081434.iA8EYHii023530@warthog.cambridge.redhat.com>
Message-ID: <Pine.GSO.4.61.0411091606150.25943@waterleaf.sonytel.be>
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
 <200411081434.iA8EYHii023530@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004 dhowells@redhat.com wrote:
> --- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/ptrace.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/ptrace.c	2004-11-05 14:13:03.199555230 +0000
> @@ -0,0 +1,771 @@
> +/*
> + *  linux/arch/m68k/kernel/ptrace.c
> + *
> + *  Copyright (C) 1994 by Hamish Macdonald
> + *  Taken from linux/kernel/ptrace.c and modified for M680x0.
> + *  linux/kernel/ptrace.c is by Ross Biro 1/23/92, edited by Linus Torvalds

Although we feel flattered that some components of the FRV port are based on
the m68k port, perhaps you can update the actual pathnames in the source files?
:-)

The same comment is valid for arch/frv/kernel/time.c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
