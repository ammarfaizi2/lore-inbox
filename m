Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbQLAWQ0>; Fri, 1 Dec 2000 17:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129547AbQLAWQH>; Fri, 1 Dec 2000 17:16:07 -0500
Received: from vp175103.reshsg.uci.edu ([128.195.175.103]:7954 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129460AbQLAWP7>; Fri, 1 Dec 2000 17:15:59 -0500
Date: Fri, 1 Dec 2000 13:45:24 -0800
Message-Id: <200012012145.eB1LjOl03300@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 driver update for 2.4
In-Reply-To: <20001201175109.A4209@saw.sw.com.sg>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18pre23 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2000 17:51:09 +0800, Andrey Savochkin <saw@saw.sw.com.sg> wrote:

> I've been promised that this issue would be looked up in Intel's errata by
> people who had the access to it, but I haven't got the results yet.

There is nothing relevant in the errata, unfortunately...

> The card itself doesn't report its revision in details.
> It can be checked by `lspci'.
> Rev 8 is 82559, if I remember, and rev 9 is 82559ER.

No, 82559ER has its own PCI id, 0x1209. There is also a newer 82559 chip
which reports a different PCI device id, 0x1030 (I have one of those).

For the old chips reporting 0x1229, revisions 1-3 are 82557, revisions
4-5 are 82558 and revisions 6-8 are 82559.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
