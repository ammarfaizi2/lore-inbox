Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbSLaHMi>; Tue, 31 Dec 2002 02:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267182AbSLaHMi>; Tue, 31 Dec 2002 02:12:38 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:24809 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S267179AbSLaHMf>;
	Tue, 31 Dec 2002 02:12:35 -0500
To: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA and hermer/orinoco_cs drivers b0rken?
References: <87u1h3fim2.fsf@lapper.ihatent.com>
	<20021226003405.014f0638.joshk@mspencer.net>
	<87u1gwuomh.fsf@lapper.ihatent.com> <20021230085529.GA12575@localhost>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 31 Dec 2002 06:44:16 +0100
In-Reply-To: <20021230085529.GA12575@localhost>
Message-ID: <878yy6zqrz.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Joshua M. Kwan" <joshk@ludicrus.ath.cx> writes:

> > Warning: Driver for device eth1 has been compiled with version 14
> > of Wireless Extension, while this program is using version 13.
> > Some things may be broken...
> 
> First of all, what kernel are you using? That's an ancient version of 
> the WE. If this is 2.4.2[01], download the following diffs from Jean's 
> fine site:
> 
> * http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/iw240_we15-6.diff
> * http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/iw241_we16-3.diff
> 

No warnings anymore, and it all works. I now have a full 2 yards of
wireless netowrk and dont have to run a cat5 over to muy couch :)

Apart from that, Jean Tourrilhes' site was a treasure of HOWTOs and
FAQs, so I'll spend a lot of time reading up there. Next thing up is
bluetooth, and the site seems to be the right place for that, too.

> Next of all, try upgrading the firmware on your card.
> 

Went trough the motions of finding NetGears support on this. NetGear
now officially has landed on my list of gear not to recommend. The
while sitiation on finding firmware and tools to flash it didn't
strike me as very orderly, and I ended up using some Dlink tools I
found through Google to get my card slightly upgraded, but it seemed
to do the trick. The other Lucent/Orinoco card I had was more simple
and done in a few minutes.

> The error writing packet to BAP error always seemed just like a small 
> nuisance to me during large file transfers. It did not correlate with 
> any connectivity problems, so I just commented it out in the 
> orinoco/hermes/orinoco_cs source (it's in one of those files.)
> 

I never got to try it on large files, I had a few dozen errors from a
card idling with no connectivity :)

> Hope your wireless endeavors succeed - I just spent all week getting 
> hostap_plx to work (and I'm now reaping the benefits because I now have 
> wifi access all over my house) :)
> 

Any benefit of using an AP over an ad-hoc network if it's only two or
three nodes in a room?

> Regards
> -Josh
> 

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
