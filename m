Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281916AbRKUPtH>; Wed, 21 Nov 2001 10:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281915AbRKUPsy>; Wed, 21 Nov 2001 10:48:54 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30480 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S281905AbRKUPsU>; Wed, 21 Nov 2001 10:48:20 -0500
Date: Wed, 21 Nov 2001 16:46:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: Adam Feuer <adamf@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Swsusp mailing list <swsusp@lister.fornax.hu>,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Gabor Kuti <seasons@falcon.sch.bme.hu>
Subject: Re: [swsusp] Re: swsusp for 2.4.14
Message-ID: <20011121164620.D31379@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011121001858.B183@elf.ucw.cz> <E166M8H-0003QH-00@the-village.bc.nu> <20011120180715.N11355@sunflower.zipcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011120180715.N11355@sunflower.zipcon.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Has anyone tried porting swsusp to user mode linux. That way you could
> > actually "suspend" a copy, resume it in parallel with the original and
> > compare the two memory images ?
> 
> Alan,
>   I got swsusp-2.4.13 (from Florent) to compile on User Mode Linux
> 2.4.13, with a couple of changes... it seems to suspend, but will not
> resume afterwards... just boots normally. Suspending doesn't seem to
> write the swsusp signature to the swap partition... 
>   I haven't gone any farther than that yet. I can provide a diff
> against uml-2.4.13 if anyone is interested in helping. :-)

Yep, I'd like to see it. [The way uml is setup with one uml kernel
running in *many* real processes, saving/restoring cpu state is not
going to be easy.]
							Pavel

-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
