Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130467AbRAaVFn>; Wed, 31 Jan 2001 16:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130205AbRAaVFY>; Wed, 31 Jan 2001 16:05:24 -0500
Received: from [193.120.246.5] ([193.120.246.5]:9867 "EHLO best.eurologic.com")
	by vger.kernel.org with ESMTP id <S130163AbRAaVFN>;
	Wed, 31 Jan 2001 16:05:13 -0500
Message-ID: <01ff01c08bc9$6b66cb00$2907a8c0@wombat>
From: "Ken Sandars" <ksandars@eurologic.com>
To: <kasten@nscl.msu.edu>, <linux-kernel@vger.kernel.org>
In-Reply-To: <200101312044.PAA11405@tiger.nscl.msu.edu>
Subject: Re: v2.4.1 missing EXPORT_SYMBOL
Date: Wed, 31 Jan 2001 21:04:37 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Eric Kasten" <kasten@nscl.msu.edu>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, January 31, 2001 8:44 PM
Subject: BUG: v2.4.1 missing EXPORT_SYMBOL


> Hi,
>
> Quick bug report for kernel 2.4.1.  There needs to be a
> EXPORT_SYMBOL(name_to_kdev_t); at the bottom of linux/init/main.c.
> name_to_kdev_t is used by the md driver (and maybe others).  If the
> driver is built as a module it won't load due to the missing symbol.
>
> ...Eric
>
> Eric Kasten
> kasten@nscl.msu.edu
> National Superconducting Cyclotron Lab
> (517) 333-6412
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>
Thanks, Eric

That does the trick for me.

Ken Sandars
ksandars@eurologic.com
Eurologic Systems
+44 117 930 9621

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
