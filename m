Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136507AbRD3Rrg>; Mon, 30 Apr 2001 13:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136509AbRD3Rr2>; Mon, 30 Apr 2001 13:47:28 -0400
Received: from shell.aros.net ([207.173.16.19]:5392 "EHLO shell.aros.net")
	by vger.kernel.org with ESMTP id <S136507AbRD3RrU>;
	Mon, 30 Apr 2001 13:47:20 -0400
Date: Mon, 30 Apr 2001 11:47:18 -0600
From: Lawrence Gold <gold@shell.aros.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oopses under 2.4.4pre8 with Tbird 1.2GHz/Epox 8kta3
Message-ID: <20010430114718.A28728@shell.aros.net>
In-Reply-To: <20010430001754.A96437@shell.aros.net> <E14uH99-0008IA-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14uH99-0008IA-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Apr 30, 2001 at 06:07:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 06:07:36PM +0100, Alan Cox wrote:
> > Could this be a sign of a faulty 3DNOW! core in my CPU?  If so, do you
> > know of any utilities I could run that test these instructions?  (For
> > Linux or Windows.)
> 
> This problem is only seen on VIA chipsets so far. Never on AMD ones.
> This leads me to the current tentative diagnosis of 'VIA chipset bug'

Thanks, at least that clears up some of the mystery.  Do you foresee any
problems with running on this setup using a kernel compiled for Athlon but
with the 3DNOW line commented out in arch/i386/config.in?  Should I go one
step further and force the use of generic mmx code in mmx.c?  (I suppose I
could just build for P2 or P3 to get the same effect.)

Thanks!

