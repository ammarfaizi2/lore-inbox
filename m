Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266999AbTBQMBs>; Mon, 17 Feb 2003 07:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267030AbTBQMBs>; Mon, 17 Feb 2003 07:01:48 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11539 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266999AbTBQMBr>; Mon, 17 Feb 2003 07:01:47 -0500
Date: Mon, 17 Feb 2003 07:08:19 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.60-mm2
In-Reply-To: <Pine.LNX.3.96.1030216205709.29049B-101000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.3.96.1030217070321.31221A-101000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; PROTOCOL="application/pgp-signature"; MICALG=pgp-sha1; BOUNDARY="Boundary-02=_pCMT+DYGeShQy4x"; CHARSET=iso-8859-1
Content-ID: <Pine.LNX.3.96.1030216205709.29049C@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary-02=_pCMT+DYGeShQy4x
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-ID: <Pine.LNX.3.96.1030216205709.29049D@gatekeeper.tmr.com>
Content-Description: signed data

On Sun, 16 Feb 2003, I wrote:

> > I've got NFS problems with 2.5.5x - 60-bk3, too, but here I can workaround 
> > them by simply pinging the NFS-server every second... Funny, but it works!
> > Perhaps this can help finding the real bug?!

[ let's try this again, not typing in a moving car ]

> I was looking for network issues when I started timing pings, and didn't
> see any. I thought it was bad timing, like not raining when you have a
> coat, but maybe I was curing it.

Since it's possible that pings will actually change the problem rather
than measure it, I'll tcpdump for a while and see if that tells me
anything. I suspected network problems, since tcp has priority over udp in
some places.

I looked at the code last night, but I don't see anything explaining a
ping making things better. Something getting flushed?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--Boundary-02=_pCMT+DYGeShQy4x
Content-Type: APPLICATION/PGP-SIGNATURE
Content-ID: <Pine.LNX.3.96.1030216205709.29049E@gatekeeper.tmr.com>
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+TMCpYAiN+WRIZzQRAkV8AJwKY8v7t1jvBMFbyNXaFt1c5QzKbQCdFcXB
/KQsXPQPTki+B5HzH3QsQZc=
=PNko
-----END PGP SIGNATURE-----

--Boundary-02=_pCMT+DYGeShQy4x--
