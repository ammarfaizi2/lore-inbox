Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264685AbRFQDld>; Sat, 16 Jun 2001 23:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264686AbRFQDlW>; Sat, 16 Jun 2001 23:41:22 -0400
Received: from 200-206-139-161-br-arqfisb1.public.telesp.net.br ([200.206.139.161]:11013
	"EHLO blackjesus.async.com.br") by vger.kernel.org with ESMTP
	id <S264685AbRFQDlJ>; Sat, 16 Jun 2001 23:41:09 -0400
Date: Sun, 17 Jun 2001 00:40:34 -0300 (BRT)
From: Christian Robottom Reis <kiko@async.com.br>
To: <eepro100@scyld.com>
cc: <saw@saw.sw.com.sg>, <linux-kernel@vger.kernel.org>
Subject: Re: eepro100 problems with 2.2.19 _and_ 2.4.0
In-Reply-To: <Pine.LNX.4.32.0106161923290.339-100000@blackjesus.async.com.br>
Message-ID: <Pine.LNX.4.32.0106170037020.191-100000@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jun 2001, Christian Robottom Reis wrote:

> I'm having a ton of problems with a set of boxes that use an onboard
> variant of the eepro100. I'm not sure what version it is (#$@#*&$@ Intel
> documentation - motherboard is model D815EEA2) but eepro100-diag reports:
>
> eepro100-diag.c:v2.05 6/13/2001 Donald Becker (becker@scyld.com)
>  http://www.scyld.com/diag/index.html
> Index #1: Found a Intel i82562 Pro/100 V adapter at 0xdf00.

I've just tested with Intel's epro-1.6.6 driver, and it does work (the
full bonanza works; simultaneous netperf and ftp and whatnot run with no
errors or hangs). This makes my situation a bit easier (and my head a bit
less confused, specially with Andrey pointing out the different versions
to the driver).

I am _very_ willing to devote some time to getting this fixed in both the
kernel and Donald's drivers if anyone is interested in tracking down the
problem. I'm not very familiar with the hardware, but I have a test box I
can use freely, a bit of time spare, and I can reproduce the problem
easily. I'd hate to see somebody else go through what I have just had to,
so it would be nice to see this fixed or documented in an official-ese
place.

Take care,
--
/\/\ Christian Reis, Senior Engineer, Async Open Source, Brazil
~\/~ http://async.com.br/~kiko/ | [+55 16] 274 4311

