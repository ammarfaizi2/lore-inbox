Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKGUpg>; Tue, 7 Nov 2000 15:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129036AbQKGUp1>; Tue, 7 Nov 2000 15:45:27 -0500
Received: from burdell.cc.gatech.edu ([130.207.3.207]:3080 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S129033AbQKGUpT>; Tue, 7 Nov 2000 15:45:19 -0500
From: "J.D. Hollis" <jdhollis@cc.gatech.edu>
To: <linux-kernel@vger.kernel.org>
Subject: linux-2.4.0test10
Date: Tue, 7 Nov 2000 15:42:23 -0500
Message-ID: <CBECJLMFDMBGLDALACILOEEOCEAA.jdhollis@cc.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey.  I'm having some strange memory problems with the 2.4 kernel.  I first
noticed in linux-2.4.0test9 (the first 2.4 kernel I installed and that I
installed about a week before 2.4.0test10 came out) that a little while
after I boot my system, my hard drive begins to seek rapidly for no apparent
reason.  after the drive stopped seeking, out of curiosity I pulled up gtop
and noticed that a sizeable amount of my 256MB of physical memory had filled
up with what gtop labelled 'Other.'  upon closer examination, all of the
processes running on my machine were only claiming about 85MB of RAM.  this
got my attention because my total RAM usage was sitting around 235MB of
physical RAM.  now, to be perfectly honest, I'm kinda curious about what's
happening with that 150MB of RAM.  of course my memory usage doesn't stay
static, but it never goes much below 235MB out of 256MB, and often spikes,
resorting to swap space.  my box is a Gateway 900MHz Athlon with 256MB of
RAM.  I'm running Redhat 6.0 (roughly, although I've done various upgrades).
if anyone needs something more specific (version numbers, detailed hardware
specs), I'll be happy to dig it up for you.  I'm not really sure what's
wrong, so I don't know what system details to include.  oh, and once I got
gtop open while the hard drive was seeking and it showed kflushd was taking
up 95% of processor, which I suppose means that it was responsible for the
strange hard drive (and possibly memory) behavior.  hope this is helpful.

cheers,
j.d.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
