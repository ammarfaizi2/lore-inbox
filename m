Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285878AbRLYUAS>; Tue, 25 Dec 2001 15:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285829AbRLYT7X>; Tue, 25 Dec 2001 14:59:23 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:50444 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S285783AbRLYT7Q>;
	Tue, 25 Dec 2001 14:59:16 -0500
Date: Tue, 25 Dec 2001 11:25:36 +0000
From: Pavel Machek <pavel@suse.cz>
To: Lionel Bouton <Lionel.Bouton@free.fr>
Cc: esr@thyrsus.com, Steven Cole <scole@lanl.gov>,
        linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
Message-ID: <20011225112535.A45@toy.ucw.cz>
In-Reply-To: <200112201721.KAA05522@tstac.esa.lanl.gov> <20011220135213.B18128@thyrsus.com> <3C273028.6070305@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3C273028.6070305@free.fr>; from Lionel.Bouton@free.fr on Mon, Dec 24, 2001 at 02:39:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This change came as a patch from David Woodhouse.  I think the new
> > abbreviations are awful ugly, myself, but they do have the virtue of
> > not being ambiguous.  So I swallowed hard and took the patch.
> > 
> 
> This could even have the nice side effect of teaching something to Linux 
> newbies (mainly the fact that the difference between 2^10 and 10^3 
> matters in some areas). I see 2 cases :
> 
> - already encountered the kiB/MiB/GiB notation and understood the 
> meaning: no problem if we take out of the equation the aesthetic of the 
> abreviations.

Heh, is it kiB or KiB? Anyway, I guess yes MiB units should be used.
We already have them in dmesg output. (And btw it confused me because
it reported *disk size* in MiB.... So I assumed MiB must be 10e6).

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MiB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

