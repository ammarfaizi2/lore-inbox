Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263825AbUDFOBy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 10:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUDFOBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 10:01:54 -0400
Received: from witte.sonytel.be ([80.88.33.193]:33264 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263825AbUDFOB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 10:01:29 -0400
Date: Tue, 6 Apr 2004 16:01:25 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [PATCH] jiffies must be unsigned long]
In-Reply-To: <1081254194.4680.3.camel@laptop.fenrus.com>
Message-ID: <Pine.GSO.4.58.0404061600540.4158@waterleaf.sonytel.be>
References: <1081254194.4680.3.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2004, Arjan van de Ven wrote:
>
> > -			for(i=jiffies+HZ/100;time_before(jiffies, i););
> > +			for(t=jiffies+HZ/100;time_before(jiffies, t););
>
> how nice... but ehm... if you fix it why not really fix it ???

Because I just want to get rid of all the annoying warnings when trying to
compile as many drivers as possible on m68k.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
