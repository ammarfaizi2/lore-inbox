Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268053AbRGVUZn>; Sun, 22 Jul 2001 16:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268054AbRGVUZd>; Sun, 22 Jul 2001 16:25:33 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:61623 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S268053AbRGVUZV>;
	Sun, 22 Jul 2001 16:25:21 -0400
Message-ID: <3B5B36D5.3F08C0BC@mandrakesoft.com>
Date: Sun, 22 Jul 2001 16:25:57 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ben Greear <greearb@candelatech.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [BUG REPORT]  Sony VAIO, 2.4.7:  CardBus failures with Tulip & 3c575 
 cards.
In-Reply-To: <3B5B1F77.D8B45FFA@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Chapter 1, AmbiCom in slot 1 hangs the sytem untill removed.

I get this too with a test 8139 that RealTek sent me.  The behavior
occurs on a Compaq K6-2 laptop and also a Toshiba P-III laptop.  I
assumed it was a bad card sent from the bowels of RealTek engineering,
but maybe not...

Changing "#if 0" to "#if 1" at the top of yenta.c, and logging the
output (perhaps with minicom, over a serial console) would probably be
interesting...

	Jeff, who swears he's still on vacation :)

-- 
Jeff Garzik      | "I wouldn't be so judgemental
Building 1024    |  if you weren't such a sick freak."
MandrakeSoft     |             -- goats.com
