Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSKTWG5>; Wed, 20 Nov 2002 17:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbSKTWFt>; Wed, 20 Nov 2002 17:05:49 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:2194 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261693AbSKTWFA>; Wed, 20 Nov 2002 17:05:00 -0500
Message-ID: <3DDC08AF.7020107@redhat.com>
Date: Wed, 20 Nov 2002 14:11:59 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading enhancements, tid-2.5.47-C0
References: <Pine.LNX.4.44.0211181303240.1639-100000@localhost.localdomain> <3DDAE822.1040400@redhat.com> <20021120033747.GB9007@bjl1.asuk.net> <3DDB09C2.3070100@redhat.com> <20021120215540.GA11879@bjl1.asuk.net>
In-Reply-To: <20021120215540.GA11879@bjl1.asuk.net>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jamie Lokier wrote:

> I don't buy this argument.  You block signals, do something, unblock
> signals.  There may be a _tiny_ delay in delivering the signal

Tiny?  You said yourself that fork can be expensive.


> - of
> the order of a single system call time, i.e. not significant.  (That
> delay is much shorter than signal delivery time itself).  No signals
> are actually _lost_,

Of course they can get lost.  Normal Unix signals are not queued.


- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE93Aiv2ijCOnn/RHQRAippAKCnwjE420nRHMJpGSm86CxNhkgtXwCgjAA3
gqpLLi1ytAanQWzIq+0+sWE=
=TRHu
-----END PGP SIGNATURE-----

