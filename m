Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129405AbQKHR6K>; Wed, 8 Nov 2000 12:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129475AbQKHR6A>; Wed, 8 Nov 2000 12:58:00 -0500
Received: from burdell.cc.gatech.edu ([130.207.3.207]:1288 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S129405AbQKHR5u>; Wed, 8 Nov 2000 12:57:50 -0500
From: "J.D. Hollis" <jdhollis@cc.gatech.edu>
To: <linux-kernel@vger.kernel.org>
Subject: major problem with linux-2.4.0test10
Date: Wed, 8 Nov 2000 12:54:55 -0500
Message-ID: <CBECJLMFDMBGLDALACILAEHJCEAA.jdhollis@cc.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having a problem with memory since 2.4.0test9...for some reason,
shortly after my system boots, my hard drive begins to seek rapidly for no
apparent reason, and suddenly about 150MB of my 256MB RAM is filled up with
something gtop labels 'Other.'  whatever's filling my memory isn't attached
to any process.   the one time I managed to get gtop open while the hard
drive was seeking, I noticed that kflushd was using about 98% of my
processor (an Athlon 900MHz).  I'm running Redhat 7.0 (although I have no
idea whether that makes a difference).

regards,
j.d.

---
J.D. Hollis (jdhollis@cc.gatech.edu)

"That which is overdesigned, too highly specific, anticipates outcome; the
anticipation of outcome guarantees, if not failure, the absence of grace." -
`All Tomorrow's Parties', William Gibson

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
