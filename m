Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267252AbTAKP24>; Sat, 11 Jan 2003 10:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267246AbTAKP24>; Sat, 11 Jan 2003 10:28:56 -0500
Received: from static24-72-2-224.reverse.accesscomm.ca ([24.72.2.224]:17815
	"EHLO rapfast.petcom.com") by vger.kernel.org with ESMTP
	id <S267221AbTAKP2y>; Sat, 11 Jan 2003 10:28:54 -0500
Message-ID: <3E203A45.B590F101@petcom.com>
Date: Sat, 11 Jan 2003 09:37:41 -0600
From: Roe Peterson <roe@petcom.com>
Organization: LiveGlobalBid.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-laptop@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: dell precision m50 _very_ slow paging/swapping
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Although Dell doesn't consider the precision M50 a laptop (it's a
"portable workstation"), this list
looks like a good place to start :-)

I'm having a big problem with a brand-new M50.  The symptoms persist
whether I try Redhat 7.3
or 8.0.

Generally, everything is fine, right up to the time the machine starts
paging out to disk.  Then, the
system essentially grinds to a halt.

The paging activity eventually gets done, and, once things are running
in RAM, the machine flies.

However, I've seen starting mozilla take ~45 seconds, and starting vi
take 15!!!

This machine:

    1.8Ghz Pentium 4 Pro Mobile CPU
    256MB RAM
    40 GB hard drive (userland benchmarks look good - 16-18 MB/sec
transfer rates)
    nVidia Quadro 4 GoGl video
    PIIX4 EIDE chipset
    i810 compatible sound
    Latest BIOS upgrade from Dell (A07)

I see the same result with redhat 7.3 and 8.0.

I've even disabled the PIIX support in the kernel, on the theory that
something in the IDE
subsystem was responsible - no change, except (as expected) user mode
disk IO slowed down
somewhat.

I freely admit I'm confused.

Dell support is:
    1 - extremely frustrating
    2 - totally useless

And I don't even want to talk about Redhat.

Can anyone point me at a theory, even??



