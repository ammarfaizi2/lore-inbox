Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265505AbTFRTWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 15:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265507AbTFRTWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 15:22:41 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:54249 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265505AbTFRTWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 15:22:34 -0400
Date: Wed, 18 Jun 2003 21:36:22 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christian Kujau <evil@g-house.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.71 compile error on alpha
In-Reply-To: <3EEF95E8.5040109@g-house.de>
Message-ID: <Pine.GSO.4.21.0306182135360.7651-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jun 2003, Christian Kujau wrote:
> i did not even know that this one is bad. the only weird thing which 
> comes into my mind when thinking about this alpha is: it is filled up 
> whith fine 128 MB RAM -- but it is only seeing 64 MB. when we inserted 
> 64 MB RAM, only 32 MB are recognized. with 32 MB working with it was no 
> fun, working with 64 MB is quite good. must be the type of RAM but i 
> don't really know much about the different RAM types.

Is this SDRAM? May be 4-bank SDRAM, while your memory controller supports
2-bank SDRAM only.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

