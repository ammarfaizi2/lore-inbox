Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAINue>; Tue, 9 Jan 2001 08:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbRAINuP>; Tue, 9 Jan 2001 08:50:15 -0500
Received: from herrmann.cherheim.etc.tu-bs.de ([134.169.88.65]:27404 "EHLO
	herrmann.cherheim.etc.tu-bs.de") by vger.kernel.org with ESMTP
	id <S129562AbRAINuH>; Tue, 9 Jan 2001 08:50:07 -0500
Message-ID: <3A5B170E.F48872A@tu-bs.de>
Date: Tue, 09 Jan 2001 14:50:06 +0100
From: Felix Maibaum <f.maibaum@tu-bs.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Subject: 2.4.0 bug in SHM an via-rhine or is it my fault?
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!

I searched the kernel archives for information on this at least half a
yearback but I found only one article on the subject and that was never
replied to:

I'm using a via-rhine chip (DFE-530TX) on a 10 Mbit network, I use 2.4.0
final, Athlon (classic) 1Gig, Abit-KA7 mobo (via KX133), Debian woody.
whenever I try to get a file on my local network, meaning I get close to
the 10Mbit barrier the network card hangs up. Traffic just stops.
One ifdown/ifup and everything works fine again. (for about 10 seconds)
this problem has persisted for some time now, I thought it would be
fixed in the final, but, alas, it hasn't. It only happens during high
traffic, too, at about 400k, no problem!


Something new that cropped up in prerelease:

My SHM stopped working!
everything was fine in test12, and after that all I got was "no space
left on device".
Has anything changed that one should know about? I mounted shm like it's
written in the help, and on a friends celeron SMP machine it works fine,
I just don't know what I did wrong.

any ideas on any of the 2 problems?

TIA

Felix Maibaum


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
