Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132922AbRDEPY2>; Thu, 5 Apr 2001 11:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132924AbRDEPYS>; Thu, 5 Apr 2001 11:24:18 -0400
Received: from flathead.gate.net ([216.219.246.5]:20420 "EHLO
	flathead.gate.net") by vger.kernel.org with ESMTP
	id <S132922AbRDEPYN>; Thu, 5 Apr 2001 11:24:13 -0400
Message-ID: <001701c0bde4$59825240$871a24cf@master>
From: "Steve Grubb" <ddata@gate.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: asm/unistd.h
Date: Thu, 5 Apr 2001 11:23:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would seem to me that after hearing how the macros are used in practice,
wouldn't turning them into inline functions be an improvement? This is
something gcc supports, it accomplishes the same thing, and has the added
advantage of type checking.
http://gcc.gnu.org/onlinedocs/gcc-2.95.3/gcc_4.html#SEC92

Or perhaps type checking macro arguments would be another fertile area for
the Stanford Checker...

Cheers,
Steve Grubb

