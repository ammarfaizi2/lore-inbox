Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131982AbQKJXhz>; Fri, 10 Nov 2000 18:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131979AbQKJXhp>; Fri, 10 Nov 2000 18:37:45 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37129 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131713AbQKJXhf>; Fri, 10 Nov 2000 18:37:35 -0500
Message-ID: <3A0C86BB.4C87A630@transmeta.com>
Date: Fri, 10 Nov 2000 15:37:31 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: APIC errors w/ 2.4.0-test11-pre2
In-Reply-To: <200011102225.XAA04339@cave.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> 
> > I have seen the same problem on the same motherboard.  It appears to
> > be a motherboard bug that 2.4 exposes and 2.2 doesn't.
> 
> This PRINT was added in 2.4.
> 
> You're seeing noise on the apic lines. The APICs notice, but every now
> and then you may see a lockup due to this. (i.e. if the corruption
> does not trigger a parity error, because two bits flipped!)
> 

What I was seeing, though, was that 2.4 would lock up with an NMI deadman
after a few days.  2.2 never did.  Even on other hardware I see very high
NMI rates, but no lockups, using 2.4.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
