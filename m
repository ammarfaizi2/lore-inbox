Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLKCDJ>; Sun, 10 Dec 2000 21:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQLKCC6>; Sun, 10 Dec 2000 21:02:58 -0500
Received: from smtp1.jp.psi.net ([154.33.63.111]:33030 "EHLO smtp1.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129228AbQLKCCq>;
	Sun, 10 Dec 2000 21:02:46 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: <linux-kernel@vger.kernel.org>
Subject: OOPS when using 4GB memory setting
Date: Mon, 11 Dec 2000 10:31:44 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGOELOCIAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3A32C0CD.AAFB756E@home.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	About 1 month back I reported a problem with getting OOPs when running with
a kernel compiled with the 4GB memory setting. Since then I've finally
managed to get the ksymoops results. Where should I post them?

	To review:

	My machine has 1GB RAM. If I build a 2.4.0test11 (or 8, 9, or 10 I haven't
tried earlier) kernel and chose the 1GB memory setting then only 900504 K is
detected (but everything runs stably). If I chose the 4GB memory setting
then the full 1 GB is detected but I get oops. I can reliably force an oops
by mounting a samba drive and then accessing it (via ls for example).


--Rainer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
