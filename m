Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265006AbSKFM1n>; Wed, 6 Nov 2002 07:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265009AbSKFM1n>; Wed, 6 Nov 2002 07:27:43 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45841 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265006AbSKFM1m>; Wed, 6 Nov 2002 07:27:42 -0500
Date: Wed, 6 Nov 2002 13:34:17 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Message-ID: <20021106123417.GC5366@atrey.karlin.mff.cuni.cz>
References: <20021103201105.GD27271@elf.ucw.cz> <Pine.LNX.4.44L.0211032303480.3411-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211032303480.3411-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Suspend *needs* to touch all drivers.
> 
> Indeed, but ...
> 
> > I do stopping at high levels already
> 
> ... does swsusp really need to duplicate the functionality of
> the APM / ACPI layers ?

Its the other way. ACPI uses swsusp to implement the sleep, and does
not do this itself.

APM is really different because in such cases BIOS does the work.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
