Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTAIK4O>; Thu, 9 Jan 2003 05:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbTAIK4O>; Thu, 9 Jan 2003 05:56:14 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:4510 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262780AbTAIK4O>;
	Thu, 9 Jan 2003 05:56:14 -0500
Date: Thu, 9 Jan 2003 12:04:46 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@digeo.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.55
In-Reply-To: <Pine.LNX.4.44.0301082033410.1438-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0301091202511.25052-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2003, Linus Torvalds wrote:
> Andrew Morton <akpm@digeo.com>:
>   o move LOG_BUF_SIZE to header/config

I find the config a bit confusing:

| Kernel log buffer size (128 KB, 64 KB, 32 KB, 16 KB, 8 KB, 4 KB) [16 KB] (NEW) ?
| Select kernel log buffer size from this list (power of 2).
| Defaults:  17 (=> 128 KB for S/390)
|            16 (=> 64 KB for x86 NUMAQ or IA-64)
|            15 (=> 32 KB for SMP)
|            14 (=> 16 KB for uniprocessor)
| 
| Kernel log buffer size (128 KB, 64 KB, 32 KB, 16 KB, 8 KB, 4 KB) [16 KB] (NEW) 

E.g. should I enter `14' or `16 KB' (or `16') for `16 KB'?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

