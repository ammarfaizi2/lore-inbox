Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTDPUmC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 16:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbTDPUmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 16:42:02 -0400
Received: from mail.casabyte.com ([209.63.254.226]:57617 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S264582AbTDPUmA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 16:42:00 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Brien" <admin@brien.com>, <linux-kernel@vger.kernel.org>
Subject: RE: my dual channel DDR 400 RAM won't work on any linux distro
Date: Wed, 16 Apr 2003 13:53:34 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGCEMNCHAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <003e01c30428$bb6de410$6901a8c0@athialsinp4oc1>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had one-hell of a problem myself relating to memory on my new cutting edge
motherboard.  The problem, it turned out, had everything to do with the
motherboard and the often marginal quality of the ram.  Much investigation
revealed that there were only a few manufacturers of ram that the MoBoard
would "support"

In lay speak, I could put any damn thing I wanted into the first slot, but
anything I did with the second and subsequent slots went all haywire.

The BS layman's speak they gave me at the store was that they had seen a lot
of cases where having "double sided SIMMs" (they were oh-so-usefully
classifying the memory based on whether there were chips on just one side,
or on both sides of the circuit card 8-) in the second and subsequent slots
never worked.

Translating that somewhat vague set of observations by less than top-shelf
observers, and the really scavenging across the manufacturer site where they
listed the specific manufacturer and model numbers of supported SIMs which
were only compatible in specific sets.  (e.g. two of "these" or three of
"those" with no mix-and-match.)  This netted me the following wisdom:

1) Mother Board claims of "up to N gig" are highly contingent.
2) It is nearly impossible to find those contingencies.
3) That is especially true before purchase.
4) The conformant products were all high end components.

This further suggests:

5) Manufacturers are not being completely scrupulous WRT Standards
conformance.
6) Retailers are not well educated about the limits induced by #5.
7) If you want a given amount of memory, make sure you get it all on one
SIMM, on in a matched set, or pre-installed by someone who has the resources
to match a set for you.

8) Individual experience varies *WIDELY* even with the same brand and model
of MoBoard and SIMM.

9) <sarcasm> This is probably a plot to force people to buy the over-priced
1Gig SIMMs instead of a pair of reasonably priced 512K SIMMs </sarcasm>

I don't know the "real cause"(tm) but I suspect it has to do with
tolerances, timing, and evil gremlins that live under SIMMs and exact a toll
on non-union data.  At these speeds 1-half of one percent error can exceed
the noise-floor almost immediately.

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Brien
Sent: Wednesday, April 16, 2003 7:59 AM
To: linux-kernel@vger.kernel.org
Subject: my dual channel DDR 400 RAM won't work on any linux distro


(I posted this on some forums and they recommended that I try here)

Hi,

I have a Gigabyte SINXP1394 motherboard, and 2 Kingston 512 MB DDR 400 (CL
2.5) RAM modules installed. Whenever I try to install any Linux
distribution, I always get a black screen after the kernel loads, when I
have dual channel enabled; If I take out 1 of the RAM modules (either one),
everything works as it should -- it's not a bad module (works perfectly
under Windows by the way). I can't disable dual channel without taking out
half of my RAM, and I really do not want to run with only half of it. Does
anyone have any idea how I can fix this problem, or is it something that
needs to be updated in the kernel?

Thanks for any info.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

