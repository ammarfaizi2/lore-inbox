Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbQKFJkE>; Mon, 6 Nov 2000 04:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129493AbQKFJjy>; Mon, 6 Nov 2000 04:39:54 -0500
Received: from smtp1.jp.psi.net ([154.33.63.111]:15377 "EHLO smtp1.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129357AbQKFJjp>;
	Mon, 6 Nov 2000 04:39:45 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: <linux-kernel@vger.kernel.org>
Subject: OOPS when using 4GB memory setting
Date: Mon, 6 Nov 2000 17:33:59 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGIEBCCHAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	Please respond directly since I'm not on this mailing list.

	I have 2 intertwined problems that my initial web research has failed to
reveal help. I recently upgraded machines and the new one has 1GB RAM. If I
build a 2.4.0pre10 (or 8 or 9, I haven't tried earlier) kernel and chose the
1GB memory setting then only 900504 K is detected (but everything runs
stably). If I chose the 4GB memory setting then the full 1 G is detected but
I get oops. I can reliably force an oops by mounting a samba drive and then
accessing it (via ls for example).
	So, is this a known issue? Should I do an oops analysis? What can I do to
fix this?

	Also 2 items of note. The kernel that comes RetHat 6.2 detects all of the
RAM and is stable. Related to this, although not that important, I also
noticed that via this RedHad kernel, hdparm shows memory access (not disk)
of over 200 MB/s. On my 2.4 kernels this is about 120MB/s. Any ideas why?
	Second, it is a dual PIII system so is an SMP kernel, if that makes a
difference.


	Any help would be greatly appreciated.

--Rainer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
