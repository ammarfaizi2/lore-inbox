Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281028AbRKGWZR>; Wed, 7 Nov 2001 17:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281026AbRKGWZH>; Wed, 7 Nov 2001 17:25:07 -0500
Received: from stingr.net ([212.193.33.37]:6405 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id <S281022AbRKGWYy>;
	Wed, 7 Nov 2001 17:24:54 -0500
Date: Thu, 8 Nov 2001 01:24:52 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Message-ID: <20011108012452.A14971@stingr.net>
Mail-Followup-To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0111062157050.25683-100000@mustard.heime.net> <Pine.GSO.4.33.0111061611080.17287-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0111061611080.17287-100000@sweetums.bluetronic.net>
User-Agent: Agent Orange
X-Mailer: mIRC32 v5.91 K.Mardam-Bey
X-RealName: Stingray Greatest Jr
Organization: Stingray Software
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Replying to Ricky Beam:
> And those who *will* complain that binary structures are hard to work with,
> (you're idiots too :-)) a struct is far easier to deal with than text
> processing, esp. for anyone who knows what they are doing.  Yes, changes

Just read the whole thread, and got my head explode. Let me reply to random
picked msg.

First, to these who know about kernel-user interaction in, for example,
windows. Win32 API has functions, which fill structs, defined in SDK headers.

Linux kernel is much more light-w ... or maybe for any other reason it does
not have that functions. pity. they can achieve performance you need. and no
need for parsing, yeah. (we also do have X, which implementation is much
more slow than winNT gui).

but.

How much time you will parse a single integer ? Without any text around
needs to be thrown away, optionally with 0x and considered it __int64 ?

This is much better than current /proc, yeah ? Anyway, Linus will keep proc
ASCII, and we don't have another Linus.

So proposed standard for /proc - is a good idea. Let's get rid of
progressbars, percent-o-meters with pseudographics. Maybe we should switch
from single file, for ex, cpuinfo, to dir with many INDIVIDUAL files
containing single number or feature-set in it. Splitting away parts that
need to be formatted in-kernel and then parsed in-user maybe a good decision
'coz ... maybe they are rarely used ?

Another point. Including formatting code in EVERY kernel part that resides in
/proc maybe (as for me) a bad idea - so one can do simple interface,
formatting functions, and switch modules to use them

Another point is writable /proc files - but no one in this thread said
something clever about it and ... maybe discuss it later ?

- -- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
-----BEGIN PGP SIGNATURE-----

iEYEAREDAAYFAjvptKwACgkQyMW8naS07KSA2QCgm0z0ICxmJxqjImrPMk7Denzx
CjIAnRCQ6WYMXa0lOMFFyYoHJpZ0jRuy
=8+oN
-----END PGP SIGNATURE-----
