Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129996AbQKHWWD>; Wed, 8 Nov 2000 17:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130098AbQKHWVx>; Wed, 8 Nov 2000 17:21:53 -0500
Received: from fe040.world-online.no ([213.142.64.154]:22671 "HELO
	mail.world-online.no") by vger.kernel.org with SMTP
	id <S129996AbQKHWVj>; Wed, 8 Nov 2000 17:21:39 -0500
Message-ID: <001601c049d2$404d2010$0201000a@tripwire>
From: "Andre Tomt" <andre@tomt.net>
To: "James Simmons" <jsimmons@suse.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0011081258310.259-100000@euclid.oak.suse.com>
Subject: Re: Network error
Date: Wed, 8 Nov 2000 23:21:29 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Something I seen on a lug. Anyone have a patch for this?
>
> I'm trying to compile a 2.2.17 kernel.  When I do a make bzImage, I get
> this error.  It seems to be centering on networking areas (nfs, svclock,
> tcp, etc.)
>
> tcp_input.c:1393:52: warning: pasting would not give a valid preprocessing
> token
> tcp_input.c:1441:85: warning: pasting would not give a valid preprocessing
> token

This is a non fatal warning, not an error. However, newer "in-development"
gcc's have other issues making it refuse to build a full kernel image.
Either fix the makefile to use a compatible cc (egcs, kgcc for example),
define CC to make, or downgrade the default compiler to anything below or
including gcc-2.95.2

Whatever makes you sleep well at night.

--
André Tomt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
