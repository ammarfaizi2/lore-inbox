Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264865AbRGSDNr>; Wed, 18 Jul 2001 23:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264874AbRGSDNi>; Wed, 18 Jul 2001 23:13:38 -0400
Received: from adsl-63-200-86-10.dsl.scrm01.pacbell.net ([63.200.86.10]:22022
	"EHLO frx774.dhs.org") by vger.kernel.org with ESMTP
	id <S264865AbRGSDNY>; Wed, 18 Jul 2001 23:13:24 -0400
From: Jesse Wyant <jrwyant@frx774.dhs.org>
Message-Id: <200107190313.f6J3DNI00574@frx774.dhs.org>
Subject: Re: Unable to handle kernel paging request at virtual address
To: sacher@dvoid.org (Dominik Sacher)
Date: Wed, 18 Jul 2001 20:13:22 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01071620272102.02650@jukebox.juke.net> from "Dominik Sacher" at Jul 16, 2001 08:27:21 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> hi !
> i not a kernel hacker, so i don't know, whom to write to.
> maybe you can help !
> i get several application-crashs on my redhat7.1 (updated to kernel 2.4.3-12) 
> and every crash produces some kind of this:

I've seen similar `Oopses' when I've compiled my ALSA sound drivers (for
my i815e motherboard's AC'97 audio) for the wrong kernel, or didn't do a 
`make clean' before recompiling ALSA.  But, to determine the problem, you
need to run your Oops output through 'ksymoops', do a 'man ksymoops' for
usage instructions.  This will attach library calls to all those pointers
in the Oops outputs.  That is where I would see that my Oopses were due
to ALSA, you should be able to better root-cause the problem this way.

-jesse

Jesse Wyant
------------------------------------------------------------
An Englishman never enjoys himself, except for a noble purpose.
		-- A.P. Herbert

