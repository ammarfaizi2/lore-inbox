Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129831AbQLBK0z>; Sat, 2 Dec 2000 05:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129933AbQLBK0p>; Sat, 2 Dec 2000 05:26:45 -0500
Received: from vp175103.reshsg.uci.edu ([128.195.175.103]:56594 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129831AbQLBK00>; Sat, 2 Dec 2000 05:26:26 -0500
Date: Sat, 2 Dec 2000 01:55:51 -0800
Message-Id: <200012020955.eB29tpK03869@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Transmeta and Linux-2.4.0-test12-pre3 [slightly off-topic]
In-Reply-To: <90a065$5ai$1@penguin.transmeta.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18pre23 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Dec 2000 21:09:25 -0800, Linus Torvalds <torvalds@transmeta.com> wrote:

> Even then XFree86 does something bad with DPMS, and will lock up the
> graphics chipset when it tries to shut down the flat panel display. 
> Solution: don't enable DPMS is XF86Config.  That's an XFree86 problem,
> but happily easily worked around. 

If it's the same bug that locks up the ATI chipset on my Dell laptop,
then you can safely enable DPMS if only enable the standby mode,
not the others (suspend and off). The panel gets turned off anyway,
even in standby.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
