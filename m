Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293458AbSDCJAN>; Wed, 3 Apr 2002 04:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293457AbSDCJAE>; Wed, 3 Apr 2002 04:00:04 -0500
Received: from [195.39.17.254] ([195.39.17.254]:44168 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S293448AbSDCI7u>;
	Wed, 3 Apr 2002 03:59:50 -0500
Date: Wed, 3 Apr 2002 09:32:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Cc: Nerijus Baliunas <nerijus@users.sourceforge.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
	<linux-ntfs-dev@lists.sourceforge.net>,
        Padraig Brady <padraig@antefacto.com>
Subject: Re: Re[2]: ANN: NTFS 2.0.1 for kernel 2.5.7 released
Message-ID: <20020403073209.GA1474@elf.ucw.cz>
In-Reply-To: <ISPFE11z1aiG4HHZM9I000037fa@mail.takas.lt> <Pine.SOL.3.96.1020329134328.18653B-100000@virgo.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > AA> > To have all files executable breaks stuff like:
> > AA> > midnight commander (won't open executable files)
> > AA> 
> > AA> Ouch, that is plain stupid... mc should be fixed. I open executables all
> > AA> the time and mc should automatically fire up a hexeditor.
> > 
> > You probably misunderstood the problem - I cannot enter archive files (.tgz, .zip)
> > in mc if these files are marked as executable - mc just tries to execute them.
> 
> Ah, that is a bad thing. (I don't use mc as you may have guessed...)

Well, not completely true. Let's see.

When you press enter, mc does default action. Default action is

execute, if file is executable

open tar gz archive, if file is named *.tgz

etc. It is actually quite reasonable. If you want to open executable
.tgz archive just do cd foo.tgz#utar.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
