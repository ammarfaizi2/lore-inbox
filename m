Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274813AbRKDTjD>; Sun, 4 Nov 2001 14:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274875AbRKDTiy>; Sun, 4 Nov 2001 14:38:54 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:36025 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S274813AbRKDTil>; Sun, 4 Nov 2001 14:38:41 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Tim Jansen <tim@tjansen.de>
To: Jakob =?iso-8859-1?q?=D8stergaard=20?= <jakob@unthought.net>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Sun, 4 Nov 2001 20:41:34 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160Skz-1rDDSyC@fmrl05.sul.t-online.com> <20011104202406.N14001@unthought.net>
In-Reply-To: <20011104202406.N14001@unthought.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <160T6C-1RvGb2C@fmrl05.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 November 2001 20:24, Jakob Østergaard wrote:
> Does this work ?   Yes of course.  But what if I ported my program to
> a 64 bit arch...  The program still compiles.  It also runs.  But the
> values are no longer correct.   Now *that* is hell.

Actually I worry more about those programs that are already compiled and will 
break when the kernel changes. But even if you recompile the code, how can 
you be sure that the programmer uses longs instead of ints for those 64 bit 
types? The C compiler allows the implicit conversion without warning. If you 
change the type the program has to be changed, no matter what you do.

> I want type information.

BTW nobody says to one-value-files can not have types (see my earlier posts 
in this thread).

bye...
