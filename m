Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbQLMAyJ>; Tue, 12 Dec 2000 19:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129866AbQLMAyA>; Tue, 12 Dec 2000 19:54:00 -0500
Received: from smtp1.jp.psi.net ([154.33.63.111]:46598 "EHLO smtp1.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129747AbQLMAxx>;
	Tue, 12 Dec 2000 19:53:53 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: RE: Signal 11 - the continuing saga
Date: Wed, 13 Dec 2000 09:22:55 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGAEAHCJAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGKENMCIAA.rmager@vgkk.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

	Ok, I just upgraded to 2.4.0test12 (although I don't think there was any
work in 12 that directly addresses this signal 11 problem). When compiling
the new kernel I chose to disable AGPGart and RDM as suggested by
davej@suse.de. I will report later if this makes any difference.

	On another, possibly related note, I'm getting some really weird behavior
with a Java program. The only reason I mention it here is because it dies
with our old friend Signal 11. Anyway, please bear with the description
below.
	I have a tiny bash script that launches a Java swing app. If I run my
script from an xterm (or gnome-terminal or whatever) then it starts up fine.
If, however, I try to launch it from my gnome taskbar's menu then it dies
with signal 11 (the Java log is available upon request). This seems to be
100% consistent, since I noticed it yesterday, even across reboots.
Interestingly, the same behavior occurs if I try to run the program from
withis JBuilder 4.
	So, is this related to the larger signal 11 problems?


	What else can I do regarding these issues to help fix it? Would a core dump
help anyone? I'd really like to contribute somehow but I need some
direction.


--Rainer

> From: CMA [mailto:cma@mclink.it]
> Did you already try to selectively disable L1 and L2 caches (if
> your box has both) and see what happens?

Anyone know how to do this?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
