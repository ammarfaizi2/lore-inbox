Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267263AbTBDOdm>; Tue, 4 Feb 2003 09:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267265AbTBDOdm>; Tue, 4 Feb 2003 09:33:42 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62732 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267263AbTBDOdl>; Tue, 4 Feb 2003 09:33:41 -0500
Date: Tue, 4 Feb 2003 09:40:14 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Tony Gale <gale@syntax.dstl.gov.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not  2.4.x,
In-Reply-To: <1044352722.18392.6.camel@syntax.dstl.gov.uk>
Message-ID: <Pine.LNX.3.96.1030204093748.32005A-101000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; MICALG=pgp-sha1; PROTOCOL="application/pgp-signature"; BOUNDARY="=-asqFefW2nfMW7q/Nq35a"
Content-ID: <Pine.LNX.3.96.1030204093748.32005B@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--=-asqFefW2nfMW7q/Nq35a
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.3.96.1030204093748.32005C@gatekeeper.tmr.com>

On 4 Feb 2003, Tony Gale wrote:

> On Mon, 2003-02-03 at 21:04, Bill Davidsen wrote:
> > 
> > That is a problem with processes left running. I do not forward
> > connections, I do not forward X, I do not (in normal practice) leave
> > anything running. A typical thing to do is to go to each machine in a
> > cluster and look for a user activity:
> >   grep "user" log/stats.readers
> >   exit
> > nothing more. And every once in a while that hangs after executing the
> > logout sequence. With the patch it hasn't to date.
> > 
> > That doesn't mean it's a fix, I don't see it every day, I just haven't
> > seen it in a few days since I put in the patch.
> 
> The ssh hang on exit "problem" is a policy of the ssh coders. It'll
> happen when you have a background job still running when you exit, which
> is still connected to the terminal.

Please go back and reread either of my comments on the topic, I think I've
made it clear that I have no background jobs, no forwarded ports, and no
forwarded X. The existance of a problem in one area doesn't mean that
nothing else is allow to cause bad behaviour.

> As I said, it's an ssh policy issue (which many people disagree with)
> and not a bug.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--=-asqFefW2nfMW7q/Nq35a
Content-Type: APPLICATION/PGP-SIGNATURE; NAME="signature.asc"
Content-ID: <Pine.LNX.3.96.1030204093748.32005D@gatekeeper.tmr.com>
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQCVAwUAPj+O0h/0GZs/Z0FlAQKbkgQAzRglvGGrNxRdod0gWhs93eYFG3KwkJ/a
LkJ9HoxAhItOcLXQOyuarJHooq44ME9Ym3Q3N2FpjFVsbrVi+/DIh2hQlF9QW/f5
PyjZIYQRBsebLm/U9uI9wqPfqaNM6jC8ulU1cRQfrYJ9CkIKhBhtbG1a7VuATgCi
S4eP/vovOx8=
=5H++
-----END PGP SIGNATURE-----

--=-asqFefW2nfMW7q/Nq35a--
