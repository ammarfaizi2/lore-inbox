Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKHDBz>; Tue, 7 Nov 2000 22:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129076AbQKHDBq>; Tue, 7 Nov 2000 22:01:46 -0500
Received: from vill.ha.smisk.nu ([212.75.83.8]:45574 "HELO mail.smisk.nu")
	by vger.kernel.org with SMTP id <S129057AbQKHDBk>;
	Tue, 7 Nov 2000 22:01:40 -0500
Message-ID: <014b01c04930$3f21c710$020a0a0a@totalmef>
From: "Magnus Naeslund\(b\)" <mag@bahnhof.se>
To: "octave klaba" <oles@ovh.net>
Cc: "Matthew Sanderson" <matthew@DaMOO.csun.edu>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1001106235858.875A-100000@DaMOO.csun.edu> <009001c048ab$7d1a7fb0$020a0a0a@totalmef> <3A07F234.80AB1D06@ovh.net>
Subject: Re: 2.2.17: do_try_to_free_pages fails, no OOM
Date: Wed, 8 Nov 2000 04:01:53 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "octave klaba" <oles@ovh.net>
> > Oct 24 00:07:39 gimme kernel: VM: do_try_to_free_pages failed for
> > postmaster...
>
> 2.2.18pre19 should fix this problem if andrea's patch is inside.
> if not, you have to patch pre18 with VM-global-2.2.18pre18-7.bz2
> if you are from europe you can downlaod it from:
>
ftp://ftp.ovh.net/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre18/VM
-global-2.2.18pre18-7.bz2
>
> Octave
>

I can confirm that pre20 + arcangelis VM-global seems to apply fine.
No troubles here, compiling it now...

Magnus

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
