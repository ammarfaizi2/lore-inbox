Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbSL1UTK>; Sat, 28 Dec 2002 15:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbSL1UTK>; Sat, 28 Dec 2002 15:19:10 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:57217 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S265854AbSL1UTI>; Sat, 28 Dec 2002 15:19:08 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'Stephen Satchell'" <list@fluent2.pyramid.net>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Want a random entropy source?
Date: Sat, 28 Dec 2002 21:27:18 +0100
Message-ID: <003b01c2aeaf$85450cc0$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <5.2.0.9.0.20021228073445.01d386c0@fluent2.pyramid.net>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try this one: http://www.vanheusden.com/mirrors/audio-entropyd-0.0.5.tgz

(and if you have an unused video4linux-device, look here:
http://www.vanheusden.com/ved/ )

-----Oorspronkelijk bericht-----
Van: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]Namens Stephen Satchell
Verzonden: zaterdag 28 december 2002 16:40
Aan: linux-kernel@vger.kernel.org
Onderwerp: Want a random entropy source?


Not too long ago I had made a submission on SlashDot on something-or-other
(oh, right, "Rube-Goldberg Type Random Number Generators?"
http://ask.slashdot.org/article.pl?sid=02/07/26/1751228&tid=137) and I
stumbled across my submission to that article.  After thinking about it, I
though it might be a reasonable thing to submit to this list as a possible
enhancement to the /dev/random driver if someone wants to try it.  My
submission was thus:

"I've been vexed that the sound card plus CD-ROM drive combination always
shows signal at around -50 dBVU in CoolEdit. So, just for grins, I decided
to capture a few seconds of the noise and analyze the properties. I was
astonished to see that the resulting signal is a white-noise pattern with a
slight emphasis at the high end (when sampled at 44 kilosamples per
second). In short, it looks like diode noise with a 4 kilohertz square wave
thrown in.

"That suggests to me that this would make a fair source of random samples,
especially after you slot out the interfering signal.

"How many computers don't have cheap sound cards and CD-ROM drives?"

For what it's worth...

Satch

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

