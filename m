Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129520AbQLBRLM>; Sat, 2 Dec 2000 12:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129475AbQLBRKx>; Sat, 2 Dec 2000 12:10:53 -0500
Received: from mailout1-1.nyroc.rr.com ([24.92.226.146]:31661 "EHLO
	mailout1-1.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S129404AbQLBRKq>; Sat, 2 Dec 2000 12:10:46 -0500
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From: "Gnea" <gnea@rochester.rr.com>
To: linux-kernel@vger.kernel.org, Gerard Sharp <gsharp@ihug.co.nz>
Subject: Re: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11
X-Mailer: Pronto v2.2.2
Date: 02 Dec 2000 11:25:48 EST
Reply-To: "Gnea" <gnea@rochester.rr.com>
In-Reply-To: <3A2785BB.EB36DDE0@ihug.co.nz>
In-Reply-To: <3A2785BB.EB36DDE0@ihug.co.nz>
Message-ID: <20001202162105.AAA28297@mail2.nyroc.rr.com@celery>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 02 Dec 2000 00:04:27 +1300, Gerard Sharp blurted forth:

> Hello.
>  [1.] One line summary of the problem:    
>  Intermittent corruption of 4 bytes in SMP kernels using HPT366
[snip]
>  [7.] Environment
>  Redhat 6.2 basis.
>  Abit BP6 Motherboard.
>  Dual Celeron 466's
>  128 Mb ram; 13.6 Gb Seagate Barracuda HDD
>  "hda: ST313620A, ATA DISK drive"
>  CD-ROM on hdd
[snip]

Have you tried updating the bios on the bp6? This solved a LOT of
problems for me, and afaik, ru is the latest... if you need a hand with
it, i've put together a dos boot disk with everything you'll need at:
http://garson.org/~gnea/bp6-biosupdate.img

just dd if=bp6-biosupdate.img of=/dev/fd0 and boot it, run awdflash.exe
and tell it to use bp6_ru.bin when it asks for a file... have it back
up the current bios (just in case) and reboot when ready.. you'll of
course need to go into the bios on reboot and reset everything to
defaults, then go thru and re-tweak (this is the proper method.. not
doing so can create further problems) all of your settings until it's
satisfactorily set... also, the overclocking might be a bad thing in
this case unless you have the proper cooling for it (lm-sensors is
great for this sort of thing :) there's a neat wm applet called wmbp6
too) so u may want to try clocking it straight at 300 for awhile and
see what effect that has.. hope this helps

-- 
	.oO gnea at rochester dot rr dot com Oo.
	    .oO url: http://garson.org/~gnea Oo.

"You can tune a filesystem, but you can't tuna fish" -unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
