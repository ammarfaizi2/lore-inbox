Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312277AbSC2XAm>; Fri, 29 Mar 2002 18:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312278AbSC2XAb>; Fri, 29 Mar 2002 18:00:31 -0500
Received: from [195.39.17.254] ([195.39.17.254]:51335 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S312277AbSC2XAT>;
	Fri, 29 Mar 2002 18:00:19 -0500
Date: Fri, 29 Mar 2002 23:17:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Eric Sandeen <sandeen@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] kmem_cache_zalloc
Message-ID: <20020329221720.GB9974@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0203271949230.32307-100000@euler24.homenet> <E16qJr8-00060I-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > was "standard" in some sense :)
> > I wonder if they (I can't remember who it was) will say
> > "kmem_cache_zalloc is a non-standard name"...
> 
> Much more useful would be kcalloc(). That way we can put all the missing 
> 32bit overflow checking into kcalloc and remove a lot of crud from the
> kernel where we have to keep doing maths checks.

What should kcalloc do?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
