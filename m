Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbSK0WWg>; Wed, 27 Nov 2002 17:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbSK0WWg>; Wed, 27 Nov 2002 17:22:36 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:63192 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S264863AbSK0WWf>;
	Wed, 27 Nov 2002 17:22:35 -0500
Date: Wed, 27 Nov 2002 23:29:27 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Larry McVoy <lm@bitmover.com>
cc: "Richard B. Tilley  (Brad)" <rtilley@vt.edu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Verifying Kernel source
In-Reply-To: <20021127092818.Q24374@work.bitmover.com>
Message-ID: <Pine.GSO.4.21.0211272326350.5044-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2002, Larry McVoy wrote:
> > What is the proper way to verify the kernel source before compiling?
> > There have been too many trojans of late in open source and free
> > software and I, for one, am getting paranoid.
> 
> If it's in BK you can be pretty sure that it is what was checked in,
> BK checksums every diff in every file.  It's not at all impossible
> to fool the checksum but it is very unlikely that you can cause 
> semantic differences in the form of a trojan horse and still fool 
> the checksums.

It depends on the checksum algorithm. If it's not `strong' (e.g. simple crc32),
I can easily add some specially tailored unused data to the code of which the
sole purpose is to make the checksum still match.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

