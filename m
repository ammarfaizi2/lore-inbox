Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311967AbSCZNrg>; Tue, 26 Mar 2002 08:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312050AbSCZNr1>; Tue, 26 Mar 2002 08:47:27 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21770 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S311967AbSCZNrP>; Tue, 26 Mar 2002 08:47:15 -0500
Date: Tue, 26 Mar 2002 14:46:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Weinehall <tao@acc.umu.se>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: save_flags() should take unsigned long
Message-ID: <20020326134635.GA3391@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020304184653.GA8646@elf.ucw.cz> <20020326142955.E16636@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > 
> > ...and here's patch to fix it... Please apply.
> 
> The correct way to fix this would be:
> 
> <in suitable header-file; suggestions welcome>
> typedef flags_t unsigned long;
> 
> If someone can just come up with the proper header-file to use, I have
> a patch that fixes up all (?) code.
> 
> My suggestion would be to keep the typedef in the same header-file as
> save_flags/restore_flags.

Yep, looks good. Try to feed it as trivial to rusty ;-).
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
