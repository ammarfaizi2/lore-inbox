Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290742AbSARQrB>; Fri, 18 Jan 2002 11:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290738AbSARQqw>; Fri, 18 Jan 2002 11:46:52 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:7179 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290739AbSARQqj>;
	Fri, 18 Jan 2002 11:46:39 -0500
Date: Sat, 12 Jan 2002 06:27:36 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
Message-ID: <20020112062735.D511@toy.ucw.cz>
In-Reply-To: <m26669olcu.fsf@goliath.csn.tu-chemnitz.de> <E16Oocq-0005tX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16Oocq-0005tX-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 10, 2002 at 11:28:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

> > is it possible to include an emulation for the CMOV* (and possible other
> > i686 instructions) for processors that dont have these (k6, pentium
> > etc.)? I think this should work like the fpu emulation. Even if its slow
> 
> The kernel isnt there to fix up the fact authors can't read. Its also very
> hard to get emulations right. I grant that this wasn't helped by the fact
> the gcc x86 folks also couldnt read the pentium pro manual correctly.

How long does it take until netscape binaries contain CMOV? We already do
FPU emulation (you can do soft-float, so you do NOT need FP emulation!), so
I guess this would begood freature.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

