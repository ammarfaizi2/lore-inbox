Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292705AbSCSVJW>; Tue, 19 Mar 2002 16:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292708AbSCSVJN>; Tue, 19 Mar 2002 16:09:13 -0500
Received: from [195.39.17.254] ([195.39.17.254]:56194 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S292705AbSCSVJF>;
	Tue, 19 Mar 2002 16:09:05 -0500
Date: Tue, 19 Mar 2002 13:06:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: yodaiken@fsmlabs.com
Cc: Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@suse.de>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020319120618.GA470@elf.ucw.cz>
In-Reply-To: <20020316131219.C20436@hq.fsmlabs.com> <Pine.LNX.4.33.0203161223290.31971-100000@penguin.transmeta.com> <20020316143916.A23204@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > To me, once you have a G of memory, wasting a few meg on unused process 
> > > memory seems no big deal.
> > 
> > It's not the process memory, and it is a whole lot than a "few meg" if 
> > your page size is 2M.
> 
> I forget what an extremist you are. My claim is that
> some processes benefit from big pages, some do not.
> A 16G process needs 2^25 bytes of PTE at 4kbytes/page if I
> did the numbers right. Just populating 4 million odd  page tables is a 
> pain. I might be wrong about it, but I wonder if just scaling
> up from a working 32 bit strategy gets you anywhere.
> If you want to optimize for gnome, you get a very different
> layout. But Hammer and ia64 are supposedly designed for huge
> databases, routing tables, and images. Our good friends at Intel

Hammer is designed for desktop, AFAICT. [Its slightly modified athlon,
you see?]
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
