Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311948AbSCXLYy>; Sun, 24 Mar 2002 06:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311940AbSCXLYp>; Sun, 24 Mar 2002 06:24:45 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44044 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S311934AbSCXLYk>; Sun, 24 Mar 2002 06:24:40 -0500
Date: Sun, 24 Mar 2002 12:24:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Stevie O <stevie@qrpff.net>
Cc: Pavel Machek <pavel@suse.cz>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
Message-ID: <20020324112418.GA15934@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3C959716.6040308@mandrakesoft.com> <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au> <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk> <3C959716.6040308@mandrakesoft.com> <5.1.0.14.2.20020324013457.022907d0@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> I disagree, and here's the main reasons:
> >> 
> >> * fadvise(2) usefulness extends past open(2).  It may be useful to call 
> >> it at various points during runtime.
> >
> >open(/proc/self/fd/0, O_NEW_FLAGS)?
> 
> So to use fadvise(), the system must have /proc mounted?

I think it is way more feasible than adding new syscall.
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
