Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbSKTCnC>; Tue, 19 Nov 2002 21:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbSKTCm7>; Tue, 19 Nov 2002 21:42:59 -0500
Received: from CPE-144-132-5-79.vic.bigpond.net.au ([144.132.5.79]:56014 "EHLO
	blacksun.dynastynet.net") by vger.kernel.org with ESMTP
	id <S265587AbSKTCm5>; Tue, 19 Nov 2002 21:42:57 -0500
Message-ID: <024101c2903f$7650a050$41368490@archaic>
From: "David McIlwraith" <quack@bigpond.net.au>
To: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0211192349460.4103-100000@imladris.surriel.com>
Subject: Re: spinlocks, the GPL, and binary-only modules
Date: Wed, 20 Nov 2002 13:49:35 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3663.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3663.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How should it? The compiler (specifically, the C preprocessor) includes the
code, thus it is not the AUTHOR violating the GPL.

----- Original Message -----
From: "Rik van Riel" <riel@conectiva.com.br>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Wednesday, November 20, 2002 12:52 PM
Subject: Re: spinlocks, the GPL, and binary-only modules


> On Tue, 19 Nov 2002, Jeff Garzik wrote:
>
> > So, since spinlocks and semaphores are (a) inline and #included into
> > your code, and (b) required for just about sane interoperation with
Linux...
> >
> > does this mean that all binary-only modules that #include kernel code
> > such as spinlocks are violating the GPL?
>
> > But who knows if #include'd code constitutes a derived work :(
>
> Only if the #included snippets of code are large enough to be
> protected by copyright, which might be true of the stuff in
> mm_inline.h and of some of the semaphore code, but probably
> isn't true of the spinlock code.
>
> Even if the code #included is large enough to be protected by
> copyright I don't know if the code including it would be considered
> a derived work. Many questions remaining...
>
> regards,
>
> Rik
> --
> Bravely reimplemented by the knights who say "NIH".
> http://www.surriel.com/ http://guru.conectiva.com/
> Current spamtrap:  <a
href=mailto:"october@surriel.com">october@surriel.com</a>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

