Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316233AbSEZRUD>; Sun, 26 May 2002 13:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316234AbSEZRUC>; Sun, 26 May 2002 13:20:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47375 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316233AbSEZRUC>; Sun, 26 May 2002 13:20:02 -0400
Date: Sun, 26 May 2002 19:20:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020526172004.GB2306@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020521222858.GA14737@elf.ucw.cz> <Pine.GSO.4.21.0205251528420.15278-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Here's suspend-to-{RAM,disk} combined patch for
> > 2.5.17. Suspend-to-disk is pretty stable and was tested in
> > 2.4-ac. Suspend-to-RAM is little more experimental, but works for me,
> > and is certainly better than disk-eating version currently in kernel.
> 
> > +#define	LINUX_REBOOT_CMD_SW_SUSPEND	0xD000FCE2
>                                                       ^^^^
> Are you sure it's system suspend and not system reset? ;-)
> Nice to see the Commodore 64 special numbers live on in Linux...

Credits go to Gabor Kuti for this one... I did not know there's a joke
hidden there ;-).
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
