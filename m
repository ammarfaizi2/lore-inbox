Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129251AbQKTSVG>; Mon, 20 Nov 2000 13:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129205AbQKTSU4>; Mon, 20 Nov 2000 13:20:56 -0500
Received: from 232-VALL-X7.libre.retevision.es ([62.83.213.232]:9088 "EHLO
	looping.es") by vger.kernel.org with ESMTP id <S129136AbQKTSUl>;
	Mon, 20 Nov 2000 13:20:41 -0500
Date: Mon, 20 Nov 2000 16:47:30 +0100
From: Ragnar Hojland Espinosa <ragnar_hojland@eresmas.com>
To: Dan Hollis <goemon@anime.net>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        linux-kernel@vger.kernel.org
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
Message-ID: <20001120164730.A176@macula.net>
In-Reply-To: <Pine.LNX.4.30.0011200115070.1076-100000@imladris.demon.co.uk> <Pine.LNX.4.30.0011191858180.18624-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
In-Reply-To: <Pine.LNX.4.30.0011191858180.18624-100000@anime.net>; from Dan Hollis on Sun, Nov 19, 2000 at 07:00:41PM -0800
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://maculaisdeadsoimmovingit/lightside
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2000 at 07:00:41PM -0800, Dan Hollis wrote:
> On Mon, 20 Nov 2000, David Woodhouse wrote:
> > On Sun, 19 Nov 2000, Dan Hollis wrote:
> > > Writeprotect the flashbios with the motherboard jumper, and remove the
> > > cmos battery.
> > > Checkmate. :-)
> > Only if you run your kernel XIP from the flash. If you load it into RAM,
> > it's still possible for an attacker to modify it. You can load new code
> > into the kernel even if the kernel doesn't make it easy for you by having
> > CONFIG_MODULES defined.
> 
> The original assertion made was that a script kiddie could modify the
> kernel so you wouldnt be able to detect a rooted box even after a reboot.
> 
> What I posted would stop that cold, 100%. Boot from writeprotected floppy,
> writeprotect the flashbios, and remove the cmos battery.

There was some patch floating around so you could boot a new kernel without
having to reboot.  And I'm guessing you could also "box" it into a plex86
vm.

-- 
____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
\ o.O|                                                   2F0D27DE025BE2302C
 =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
   U     chaos and madness await thee at its end."       hkp://keys.pgp.com

Handle via comment channels only.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
