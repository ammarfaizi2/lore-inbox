Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbTBPCkE>; Sat, 15 Feb 2003 21:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbTBPCkE>; Sat, 15 Feb 2003 21:40:04 -0500
Received: from sysdoor.net ([62.212.103.239]:8457 "EHLO celia")
	by vger.kernel.org with ESMTP id <S265667AbTBPCkC>;
	Sat, 15 Feb 2003 21:40:02 -0500
Message-ID: <002e01c2d566$25c2f770$800afea9@s0h.dev>
From: "Michael Vergoz" <mvergoz@sysdoor.com>
To: "William Lee Irwin III" <wli@holomorphy.com>,
       "Anton Blanchard" <anton@samba.org>
Cc: "Tim Schmielau" <tim@physik3.uni-rostock.de>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>
References: <Pine.LNX.4.33L2.0302040935230.6174-100000@dragon.pdx.osdl.net> <Pine.LNX.4.33.0302160232120.7975-100000@gans.physik3.uni-rostock.de> <20030216020808.GF9833@krispykreme> <20030216024317.GM29983@holomorphy.com>
Subject: Re: [PATCH] make jiffies wrap 5 min after boot
Date: Sun, 16 Feb 2003 03:50:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sure.

rdgs
Michael V

Sent: Sunday, February 16, 2003 3:43 AM
Subject: Re: [PATCH] make jiffies wrap 5 min after boot


> At some point in the past, someone else wrote:
> >> +#define INITIAL_JIFFIES (0xffffffffUL & (unsigned long)(-300*HZ))
>
> On Sun, Feb 16, 2003 at 01:08:08PM +1100, Anton Blanchard wrote:
> > In order to make 64bit arches wrap too, you might want to use -1UL here.
> > Not that jiffies should wrap on a 64bit machine...
>
> Can I get a vote for ~0UL instead of -1UL?
>
> -- wli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

