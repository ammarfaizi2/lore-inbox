Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSDYKkP>; Thu, 25 Apr 2002 06:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313062AbSDYKkP>; Thu, 25 Apr 2002 06:40:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42506 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S313060AbSDYKkO>; Thu, 25 Apr 2002 06:40:14 -0400
Date: Thu, 25 Apr 2002 12:40:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>, Pavel Machek <pavel@ucw.cz>,
        Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Warn about trap for programmer in mm.h
Message-ID: <20020425104014.GE6510@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020425100440.GA5061@elf.ucw.cz> <20020425121308.I14343@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  >  #define PG_private		16	/* Has something at ->private */
>  > +/* Top 8 bits are used for page's zone in 2.4-ac and 2.5, don't use them */
>  >  
> 
> Erm, and 2.4 mainline these days isn't it?

Rusty, its up to you. You can s/2.4-ac and 2.5//, but it is "correct"
in any way ;-).
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
