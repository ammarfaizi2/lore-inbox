Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132248AbRBKKrn>; Sun, 11 Feb 2001 05:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132253AbRBKKrf>; Sun, 11 Feb 2001 05:47:35 -0500
Received: from [194.213.32.137] ([194.213.32.137]:13060 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132252AbRBKKrT>;
	Sun, 11 Feb 2001 05:47:19 -0500
Message-ID: <20010210225807.F7877@bug.ucw.cz>
Date: Sat, 10 Feb 2001 22:58:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tom Eastep <teastep@seattlefirewall.dyndns.org>,
        "Michael B. Trausch" <fd0man@crosswinds.net>
Cc: Josh Myer <jbm@joshisanerd.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
In-Reply-To: <Pine.LNX.4.21.0102040756120.5276-100000@fd0man.accesstoledo.com> <Pine.LNX.4.30.0102040908320.877-100000@wookie.seattlefirewall.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.30.0102040908320.877-100000@wookie.seattlefirewall.dyndns.org>; from Tom Eastep on Sun, Feb 04, 2001 at 09:18:43AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've discovered that heavy use of vesafb can be a major source of clock
> drift on my system, especially if I don't specify "ypan" or "ywrap". On my
> system (similar Hw/Sw configuration to yours), a 2.4 kernel "make dep"
> from a vesafb console will cause the system clock to drift 10-12
> seconds.

Hmm, I can make it loose 30 seconds in 12 seconds. Just cat
/etc/termcap. Vesafb does this kind of stuff. [Yes, 3 times slower
clock].

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
