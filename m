Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129814AbRBCVId>; Sat, 3 Feb 2001 16:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130421AbRBCVIX>; Sat, 3 Feb 2001 16:08:23 -0500
Received: from srvr3.telecom.lt ([212.59.0.2]:12037 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S129814AbRBCVIE>;
	Sat, 3 Feb 2001 16:08:04 -0500
Reply-To: <nerijus@freemail.lt>
From: "Nerijus Baliunas" <nerijus@users.sourceforge.net>
To: "Rhys Jones" <linux-kernel@postwales.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Need for more ISO8859 codepages?
Date: Sat, 3 Feb 2001 23:08:00 +0200
Message-ID: <MPBBJGBJAHHNDMMBBLMIKEPNFKAB.nerijus@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <4755.137.44.4.15.981028098.squirrel@www.sucs.swan.ac.uk>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> About 18 months ago I patched fs/nls/ to include support for the
> Celtic character set, ISO8859-14. I notice that there are still gaps
> in nls, specifically in ISO8859 codepages 10 to 13.
> 
> The missing codepages are for Nordic/Icelandic (ISO8859-10), Thai
> (ISO8859-11), and Baltic Rim (ISO8859-13) languages. I'm still trying
> to determine the status of ISO8859-12 at the moment.
> 
> Two questions, really. The general one is whether anyone would find
> these codepages useful. If they would, I'm willing to provide the
> patches in due course. More specifically, can anyone tell me why
> ISO8859-10 (Icelandic etc.) is mentioned in Documentation/Configure.help
> whilst nls_iso8859-10.c is missing from the fs/nls directory?

Hello,

ISO8859-13 is used in Latvia and Lithuania, so it would be useful.
I don't think ISO8859-12 is really used, it is reserved for
Devanagari (Indian), but I think they will use unicode eventually...
So it would be nice to add support for ISO8859-10 and ISO8859-13
at least.

Regards,
Nerijus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
