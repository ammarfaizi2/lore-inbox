Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKALFa>; Wed, 1 Nov 2000 06:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129991AbQKALFU>; Wed, 1 Nov 2000 06:05:20 -0500
Received: from jabberwock.ucw.cz ([62.168.0.131]:37894 "EHLO jabberwock.ucw.cz")
	by vger.kernel.org with ESMTP id <S129130AbQKALFF>;
	Wed, 1 Nov 2000 06:05:05 -0500
Date: Wed, 1 Nov 2000 12:04:05 +0100
From: Martin Mares <mj@suse.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andre Hedrick <andre@linux-ide.org>,
        Stephen Rothwell <sfr@linuxcare.com.au>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH] make my life easier ...
Message-ID: <20001101120405.C1110@albireo.ucw.cz>
In-Reply-To: <200010250515.e9P5FJA01244@wattle.linuxcare.com.au> <Pine.LNX.4.10.10010242250160.3499-200000@master.linux-ide.org> <20001025134252.A1024@albireo.ucw.cz> <20001025105900.A23985@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001025105900.A23985@opus.bloom.county>; from trini@kernel.crashing.org on Wed, Oct 25, 2000 at 10:59:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Aside from all of the other comments that've been made, because the user might
> have tweeked them at boot.  ie turn on UDMA.  If we just re-initalized on
> wakeup, you loose this.

I've of course meant reinitialize with the user-supplied settings, just as we
do during normal initialization/configuration of the driver.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
"The computer is mightier than the pen, the sword, and usually, the programmer."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
