Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267735AbSLSW3e>; Thu, 19 Dec 2002 17:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267716AbSLSW2G>; Thu, 19 Dec 2002 17:28:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:25356 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267710AbSLSW0v>; Thu, 19 Dec 2002 17:26:51 -0500
Date: Thu, 19 Dec 2002 23:34:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021219223451.GG17941@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com> <Pine.LNX.4.50.0212162241150.26163-100000@twinlark.arctic.org> <20021218235327.GC705@elf.ucw.cz> <3E0245C1.5060902@transmeta.com> <20021219222136.GC17941@atrey.karlin.mff.cuni.cz> <3E0246DE.2010608@transmeta.com> <20021219222614.GE17941@atrey.karlin.mff.cuni.cz> <3E024880.4010802@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E024880.4010802@transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > User on cpu1 reads time, communicates it to cpu2, but cpu2 is drifted
> > -50ns, so it reads time "before" time reported cpu1. And gets confused.
> > 
> 
> How can you get that communication to happen in < 50 ns?

I'm not sure I can do that, but I'm not sure I can't either. CPUs
snoop each other's cache, and that's supposed to be fast...

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
