Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313504AbSDPCcf>; Mon, 15 Apr 2002 22:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313530AbSDPCcf>; Mon, 15 Apr 2002 22:32:35 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:2824 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S313504AbSDPCce>;
	Mon, 15 Apr 2002 22:32:34 -0400
Date: Mon, 15 Apr 2002 22:32:28 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>
Subject: [RFC] Making drivers/char/watchdog
Message-ID: <Pine.LNX.4.33.0204152222100.17511-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This e-mail probably doesn't affect 99% of you out there, but it's coming
into your inboxes anyways :-).  How would people feel about moving the
22 watchdog drivers into their own subdirectory off of drivers/char/ in
both 2.4 and 2.5?  (Well, 2.5 only has 18 at the moment, but I'm planning
on adding the 4 2.4-only drivers to 2.5 once updating 2.4 is done)

I've received a bunch of inquiries about breaking them into their own
subdirectory.  At the moment there are 20 watchdog drivers in
drivers/char/ and 2 in drivers/sbus/char/ in 2.4, and 16 in drivers/char/
and 2 in drivers/sbus/char/ in 2.5.  I think putting them all into one
place will make them easier to maintain, more standardized, and less
buggy.

Regards,
Rob Radez


