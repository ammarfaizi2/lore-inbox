Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262468AbRE3AJ2>; Tue, 29 May 2001 20:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbRE3AJS>; Tue, 29 May 2001 20:09:18 -0400
Received: from gecius-0.dsl.speakeasy.net ([216.254.67.146]:62192 "EHLO
	maniac.gecius.de") by vger.kernel.org with ESMTP id <S262483AbRE3AJD>;
	Tue, 29 May 2001 20:09:03 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 kernel freeze
In-Reply-To: <3B10ECF2.220E1DFB@bluewin.ch>
From: Jens Gecius <jens@gecius.de>
Date: 27 May 2001 22:50:12 -0400
In-Reply-To: <3B10ECF2.220E1DFB@bluewin.ch> (Stephan Brauss's message of "Sun, 27 May 2001 14:02:58 +0200")
Message-ID: <878zjiqja3.fsf@maniac.gecius.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Stephan Brauss <sbrauss@bluewin.ch> writes:

> > Any other hints are welcome (other than the noapic, which didn't help).

> My system is always completely dead as soon as I start a larger (interrupt
> driven?) data transfer to/from any (? I tested with two different NICs and a Promise
> Ultra100) PCI card in slot 4 or 5. And it seems that it really only occurs 
> in slots 4 and 5... To get rid of it, I switched to 2.2.19.

I couldn't. Problems getting devfsd patched in 2.2.19 :-( - and I'm
going on vacation in shortly...

Now after the last couple of "lost interrupts" I set a debian-stable
as my primary firewall/router box in front of my server - this way I
got rid of the second nic and freed both slot 4 and 5. Unfortunately,
after a couple hours running my box again lost irq :-(.

And there's no obvious huge transfer going on. The boxes were just
alone. Now I try again noapic (different setup). Hope that
works. Otherwise I'm kind of lost...

-- 
Tschoe,                    Get my gpg-public-key here
 Jens                     http://gecius.de/gpg-key.txt
