Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263975AbRFNDtT>; Wed, 13 Jun 2001 23:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263993AbRFNDtJ>; Wed, 13 Jun 2001 23:49:09 -0400
Received: from fluent1.pyramid.net ([206.100.220.212]:27691 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S263975AbRFNDs6>; Wed, 13 Jun 2001 23:48:58 -0400
Message-Id: <4.3.2.7.2.20010613204443.00bbb150@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 13 Jun 2001 20:48:19 -0700
To: Rik van Riel <riel@conectiva.com.br>, Daniel <ddickman@nyc.rr.com>
From: Stephen Satchell <satch@fluent-access.com>
Subject: Re: obsolete code must die
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0106140018140.14934-100000@imladris.rielhome
 .conectiva>
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:24 AM 6/14/01 -0300, Rik van Riel wrote:
>Everything you propose to get rid of are DRIVERS.  They
>do NOT complicate the core kernel, do NOT introduce bugs
>in the core kernel and have absolutely NOTHING to do with
>how simple or maintainable the core kernel is.

Not quite.  There were two non-driver suggestions that the man did 
make:  remove 386/486 support and remove floating-point emulation 
support.  Both are bad for the embedded-systems space, because the 486 is 
still used there widely.

Are all the bus support code exclusively in drivers, or is there something 
compiled into the nucleus for start-up?

I didn't see your "don't feed the troll" sign before...

Satch

