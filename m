Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281018AbRKLVsd>; Mon, 12 Nov 2001 16:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281028AbRKLVsY>; Mon, 12 Nov 2001 16:48:24 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:61800 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S281018AbRKLVsH>; Mon, 12 Nov 2001 16:48:07 -0500
Date: Tue, 13 Nov 2001 08:59:04 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeronimo Pellegrini <pellegrini@mpcnet.com.br>,
        Nils Philippsen <nils@wombat.dialup.fht-esslingen.de>, vojtech@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VIA timer fix was removed?
In-Reply-To: <E163Og3-0007Aw-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.05.10111130849030.3768-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Attached (untested) patch against 21.2.20 (which still has the $SUBJECT
> > code) should implement timer=no-via686a option to disable this.  Hopefully
> > I'll get it tested in the next day or two.

Oops, my typo: s/21.2.20/2.2.20/

On Mon, 12 Nov 2001, Alan Cox wrote:

> This isnt the real problem - we are seeing it triggered by cases we dont
> underatand that seem to be software. We need to find those

Fair enough (and I make no pretence to knowing where to start to address
the real problem here).

Meanwhile, for those of us that have either suspected or confirmed
problems with the VIA686a workaround (<sigh> possibly due to entirely
different hardware/BIOS bugs? </sigh>), a method of nobbling the VIA686a
fix at compile or boot time could be somewhat useful?  Mmm... boot-time is
probably best as it allows easiet experimentation?

Thanks,
Neale.

