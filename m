Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbQLHCqF>; Thu, 7 Dec 2000 21:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130378AbQLHCpz>; Thu, 7 Dec 2000 21:45:55 -0500
Received: from smtp1.jp.psi.net ([154.33.63.111]:49425 "EHLO smtp1.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129868AbQLHCph>;
	Thu, 7 Dec 2000 21:45:37 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Signal 11
Date: Fri, 8 Dec 2000 11:14:26 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGGEFMCIAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <20001207170919.B9121@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	Thanks for all the input so far. Regarding this...

> (I'm not sure exactly what cerberos does, do you have a link for it ?).

The official name is "Cerberus Test Control System" aka CTCS. I don't know
the official site but a search for this should reveal something. Anyway it
is a pretty comprehensive test that includes multiple kernel compiles,
memory tests, disk test, etc, etc. Like I said, I ran this for more than 15
hours with no problems.

Well, actually, I did notice that if I run CTCS from within X then it
freezes up after a few minutes. This appears to happen when/because of
extreme swapping.


Aside from the above I've also run repeated kernel compiles (more than 50
times) with 'make -j bzImage' and had no problems; all outputs were
identical.

So given these tests, I'm reasonably confident the core hardware is ok. I
suppose it is possible there's some iffy bits in the G400's VRAM (but
wouldn't that just result in screen artifacts?). I will admit that I have't
yet tried swapping RAM or any other system components.


Any other ideas?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
