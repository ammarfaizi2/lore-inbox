Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315606AbSECIkE>; Fri, 3 May 2002 04:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315607AbSECIkD>; Fri, 3 May 2002 04:40:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56075 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S315606AbSECIkB>; Fri, 3 May 2002 04:40:01 -0400
Date: Fri, 3 May 2002 10:40:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing checks in exec_permission_light()
Message-ID: <20020503084001.GF22895@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020503080356.GB232@elf.ucw.cz> <Pine.GSO.4.21.0205030432050.18432-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +	if (S_ISDIR(inode->i_mode) && capable(CAP_DAC_READ_SEARCH))
> > > +		return 0;
> > 
> > Is this right? This means that root can do cat /, no? That does not
> > seem like expected behaviour.
> 
> 1) it's permission(..., MAY_EXEC)

Okay, sorry.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
