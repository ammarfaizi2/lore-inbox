Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315169AbSEJLay>; Fri, 10 May 2002 07:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315557AbSEJLay>; Fri, 10 May 2002 07:30:54 -0400
Received: from eos.telenet-ops.be ([195.130.132.40]:5080 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S315169AbSEJLaw>; Fri, 10 May 2002 07:30:52 -0400
Date: Fri, 10 May 2002 13:30:43 +0200
From: Kurt Roeckx <Q@ping.be>
To: =?iso-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sb16 isa non-pnp problems
Message-ID: <20020510133042.A6618@ping.be>
In-Reply-To: <001101c1f7c1$c233fba0$0319450a@sandos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 03:26:49AM +0200, John Bäckstrand wrote:
> Ive been trying to get my sb16 isa non-pnp working on a
> old 486, it has got two isa slots.
> 
> Ive checked the config of both my two NICs (tried two
> different ones), and the config on my sb16, no
> conflicts, and I am sure that I set the correct
> parameters. I also tried a pnp isa sb16 (vibra). Ive
> tried 2.2.20 and 2.4.17, both compiled in and module,
> but not every possible combination though.
> 
> The problems Im seeing is for the pnp card that it isnt
> detected at all, even if I do modprobe sb io=0x220
> dma=1 irq=5, I guess that is because I cant seem to be
> able to configure it using pnp, isapnp didnt print
> anything and the conf-files seemed very long-winded.

I still have a SB16 ISA non-PNP around here and used it until a
few months ago.  It always worked perfectly.  It worked with 2.4,
2.2, 2.0 and older.

In my lilo.conf I had: append="sb=0x220,7,1,5"

So io=0x220, irq=7, dma=1 and dma16=5


Kurt

