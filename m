Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290738AbSARQrB>; Fri, 18 Jan 2002 11:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290739AbSARQqx>; Fri, 18 Jan 2002 11:46:53 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:7691 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290740AbSARQqj>;
	Fri, 18 Jan 2002 11:46:39 -0500
Date: Sat, 12 Jan 2002 06:31:36 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
Message-ID: <20020112063136.E511@toy.ucw.cz>
In-Reply-To: <m26669olcu.fsf@goliath.csn.tu-chemnitz.de.suse.lists.linux.kernel> <E16Oocq-0005tX-00@the-village.bc.nu.suse.lists.linux.kernel> <p737kqpp60w.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <p737kqpp60w.fsf@oldwotan.suse.de>; from ak@suse.de on Fri, Jan 11, 2002 at 10:54:07AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The kernel isnt there to fix up the fact authors can't read. Its also very
> > hard to get emulations right. I grant that this wasn't helped by the fact
> > the gcc x86 folks also couldnt read the pentium pro manual correctly.
> 
> One corner case where emulation would IMHO make sense would be CMPXCHG8.
> It would allow to do efficient inline mutexes in pthreads, and hit the
> emulation only on 386/486. cpu feature flag checking is unfortunately
> not an option normally for inline code.
> 
> -Andi (who would have already done it if he had an 486/386 to test) 

Do you want one? I have elonex, which is 486sx, small and quiet (needs 
NFS root). But I'd want it back eventually. Or I might be able to get
you some 386...
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

