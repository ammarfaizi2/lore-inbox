Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUBJWed (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 17:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUBJWed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 17:34:33 -0500
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:23256 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261965AbUBJWec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 17:34:32 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16425.23657.260019.741516@wombat.chubb.wattle.id.au>
Date: Wed, 11 Feb 2004 09:34:17 +1100
To: Meelis Roos <mroos@linux.ee>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-rc1: snd_intel8x0 still too fast
In-Reply-To: <Pine.GSO.4.44.0402101256450.4333-100000@math.ut.ee>
References: <s5hhdy02is7.wl@alsa2.suse.de>
	<Pine.GSO.4.44.0402101256450.4333-100000@math.ut.ee>
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Meelis" == Meelis Roos <mroos@linux.ee> writes:

>> > Today mplayer was OK when I tested, didn't retry KDE login. But
>> the > kernel is the same, I have not rebooted inbetween.
>> 
>> weird...  cpufreq is running?


Meelis> mplayer /usr/share/sounds/KDE_Startup.wav gives the same very
Meelis> fast sound since it's a 22 KHz mono sample.

It's a mono/stereo thing.  I've seen the same problem here: the quick
workaround is to convert mono to stereo before playing.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
