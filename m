Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129577AbRBEOvH>; Mon, 5 Feb 2001 09:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129775AbRBEOu5>; Mon, 5 Feb 2001 09:50:57 -0500
Received: from pop.gmx.net ([194.221.183.20]:43929 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129577AbRBEOuu>;
	Mon, 5 Feb 2001 09:50:50 -0500
Date: Mon, 5 Feb 2001 15:51:45 +0100
From: ksa1 <ksa1@gmx.de>
X-Mailer: The Bat! (v1.47 Halloween Edition) Personal
Reply-To: ksa1@gmx.de
X-Priority: 3 (Normal)
Message-ID: <1915665718.20010205155145@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: d-link dfe-530 tx (bug-report)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

..I installed Manfred's patch and the d-link-card was now able to
reset after the tx-timeout-error. that means that the card was again
reachable after the error. but the smb-transfer-connection-error still
appeared. then I set "static int debug = 2;" in the patched
via-rhine.c to get more debug-informations but from then on the card
worked without errors!? I tested this several times and produced a lot
of network traffic - but there was no more error-message!

..but I will do some more tests to get sure. ;-)

bye.

--
Kristof    mailto:ksa1@gmx.de


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
