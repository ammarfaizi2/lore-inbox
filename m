Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268803AbUJKLea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268803AbUJKLea (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 07:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268812AbUJKLea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 07:34:30 -0400
Received: from witte.sonytel.be ([80.88.33.193]:13223 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268803AbUJKLe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 07:34:27 -0400
Date: Mon, 11 Oct 2004 13:33:58 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dave Jones <davej@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: __init dependencies (was: Re: [PATCH] find_isa_irq_pin can't be
 )__init
In-Reply-To: <20041010225717.GA27705@redhat.com>
Message-ID: <Pine.GSO.4.61.0410111333260.19312@waterleaf.sonytel.be>
References: <20041010225717.GA27705@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Oct 2004, Dave Jones wrote:
> As spotted by one of our Fedora users, we sometimes
> oops during shutdown (http://www.roberthancock.com/kerneloops.png)
> because disable_IO_APIC() wants to call find_isa_irq_pin(),
> which we threw away during init.

I guess it's about time for a tool to autodetect __init dependencies?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
