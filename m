Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316823AbSE1QQn>; Tue, 28 May 2002 12:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSE1QQm>; Tue, 28 May 2002 12:16:42 -0400
Received: from smtp01.fields.gol.com ([203.216.5.131]:40205 "EHLO
	smtp01.fields.gol.com") by vger.kernel.org with ESMTP
	id <S316823AbSE1QQl>; Tue, 28 May 2002 12:16:41 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Keith Owens <kaos@ocs.com.au>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config
In-Reply-To: <3937.1022552654@kao2.melbourne.sgi.com>
	<buo3cwdf0b0.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20020528030200.GL20729@conectiva.com.br>
	<20020528140322.GA6320@werewolf.able.es>
	<15603.38007.42661.75173@kim.it.uu.se>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
From: Miles Bader <miles@gnu.org>
Date: 29 May 2002 01:16:30 +0900
Message-ID: <87r8jws0wx.fsf@tc-1-100.kawasaki.gol.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Abuse-Complaints: abuse@gol.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:
> I agree with Keith that we really should prefer standard C solutions
> over gcc-specific hacks _when_they_exist_.

Since portability to other compilers is really not an option with linux,
it's a lot more important that the kernel code use a _consistent_
convention than it use a `standard' one.

So before recommending that people use a different syntax than the one
historically used, are you going to run over the whole kernel and
replace all the existing uses of `field:' with `.field = ' (and brave
the flamewar that it would probably require)?

-Miles
-- 
Suburbia: where they tear out the trees and then name streets after them.
