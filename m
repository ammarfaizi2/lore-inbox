Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131338AbRAGMsL>; Sun, 7 Jan 2001 07:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131430AbRAGMrv>; Sun, 7 Jan 2001 07:47:51 -0500
Received: from slamp.tomt.net ([195.139.204.145]:56719 "HELO slamp.tomt.net")
	by vger.kernel.org with SMTP id <S131338AbRAGMro>;
	Sun, 7 Jan 2001 07:47:44 -0500
From: "Andre Tomt" <andre@tomt.net>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: "Ville Herva" <vherva@mail.niksula.cs.hut.fi>
Subject: RE: Which kernel fixes the VM issues?
Date: Sun, 7 Jan 2001 13:47:39 +0100
Message-ID: <OPECLOJPBIHLFIBNOMGBKENCCHAA.andre@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <20010107140607.J1265@niksula.cs.hut.fi>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This issue is fixed in 2.2.18 AFAIK (never seen it since).
>
> Nope.
>
> It's fixed 2.2.19pre2 (which includes the Andrea Arcangeli's vm-global-7
> patch that (among other things) fixes this.)

I stand corrected. Still, with almost-vanilla 2.2.18 (+ ow patches) on a
highly loaded webserver has not shown any "LRU block list corruption"
crashes in over 6 weeks, even when it usually died after a week on 2.2.17
with the same error (if memory serves me right). Could be the system tuning
that has "fixed" this by making the usual load not - err - load the server
as much as before.

> You can also apply the vm-global-patch to 2.2.18 if you like.

Yep, as stated in my previous mail :-)

Ah well, time to go pack for military service (1 year, bleh).

Thanks.

--
Andre? Alfred.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
