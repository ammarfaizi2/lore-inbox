Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282196AbRKWSDE>; Fri, 23 Nov 2001 13:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282198AbRKWSCy>; Fri, 23 Nov 2001 13:02:54 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:16399 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S282196AbRKWSCr> convert rfc822-to-8bit; Fri, 23 Nov 2001 13:02:47 -0500
Date: Fri, 23 Nov 2001 10:02:50 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Which gcc version?
In-Reply-To: <E167Jsj-00002C-00@DervishD>
Message-ID: <Pine.LNX.4.33.0111230953170.18098-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2001, [ISO-8859-1] Raúl[ISO-8859-1] Núñez de Arenas  Coronado wrote:

>     Sooner or later the kernel will need to be ported to gcc 3.x
> series, so, the sooner it gets tested with this compiler, the better.

One of the regression tests for gcc is to compile *a* Linux kernel, although
I have no clue which kernel they use, or if they just haul down the latest one
from the Internet.

>     Anyway, if you have gcc 2.95.x installed onto your distro, use
> that for the kernel for maximum stability.

I haven't seen it on RH 7.x; I had to download and install it separately. And
it is a *royal* pain to get all the symbols/paths/libraries, etc., correct if
you want to use *anything* other than the default compiler/libraries/binutils
with Red Hat.  One would need extreme motivation and extreme care.

For you (fellow) Athlon geeks, 2.95.x generates better code than either 2.96.x
or 3.0.x on the Atlas high-speed numerical linear algebra library. The reverse
is true for IA64; 3.0.x is about the only thing that generates decent code. If
that's motivating enough, have at it. YMMV.
--
znmeb@aracnet.com (M. Edward Borasky) http://www.aracnet.com/~znmeb
Relax! Run Your Own Brain with Neuro-Semantics!
http://www.aracnet.com/~znmeb/Flyer.htm

When puns are outlawed, only inlaws will have gnus.

