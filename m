Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267372AbTBKRgE>; Tue, 11 Feb 2003 12:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267879AbTBKRgD>; Tue, 11 Feb 2003 12:36:03 -0500
Received: from h214n1fls32o988.telia.com ([62.20.176.214]:8977 "EHLO
	sirius.nix.badanka.com") by vger.kernel.org with ESMTP
	id <S267372AbTBKRfx>; Tue, 11 Feb 2003 12:35:53 -0500
Message-Id: <200302111745.h1BHjdPY067992@sirius.nix.badanka.com>
Date: Tue, 11 Feb 2003 18:44:59 +0100
From: Henrik Persson <nix@socialism.nu>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via rhine bug? (timeouts and resets)
In-Reply-To: <20030211171736.GA1359@k3.hellgate.ch>
References: <200302111344.h1BDiMPY067070@sirius.nix.badanka.com>
	<20030211154449.GA2252@k3.hellgate.ch>
	<200302111652.h1BGq0PY067795@sirius.nix.badanka.com>
	<20030211171736.GA1359@k3.hellgate.ch>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.OUXSHk54?x(Uu+"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.OUXSHk54?x(Uu+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2003 18:17:36 +0100
Roger Luethi <rl@hellgate.ch> wrote:

RL> > Well.. It didn't solve my problems.. Still the same errors.. :/
RL> 
RL> That I find hard to believe. You were seeing a combination of "MII
RL> status changed" and "Abort 0208, frame dropped.". That's because the
RL> driver makes two mistakes: It treats 0200 as a link change (first
RL> message), and it thinks 0008 indicates excessive collisions (second
RL> message).

RL> In fact, 0008 means "transmission error", and 0200 specifies a buffer
RL> underrun. The patch fixes that (lines 204, 213). If you are seeing the
RL> _same_ errors my guess is you're still running the old driver. Check
RL> the log at debug=3.


Darn. The same PROBLEMS, not the same errors. Indeed, the errors are not
there. But the behaviour is still the same, i.e. slow speeds after a
while.. :/

But it's not as bad as it got a few minutes ago when I tested the driver
from scyld.com.. It totally trashed my NIC.. A shame though, since it ran
perfectly until it totally died.. I wan't a combination of those drivers..
;)

RL> > Nah, that was "just in case".. ;)
RL> 
RL> It's masking another bug that's waiting to hit you <g>.

Woohoo. Ehm. Nah. ;)

-- 
Henrik Persson
e-mail: nix@socialism.nu  WWW: http://nix.badanka.com
ICQ: 26019058             PGP/GPG: http://nix.badanka.com/pgp
PGP-Key-ID: 0x43B68116    PGP-Keyserver: pgp.mit.edu

--=.OUXSHk54?x(Uu+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+STae+uW4/EO2gRYRApExAJ9Rqj3KwZoNJ+7r9mgVlVG+gar4vwCeO9O8
RSBApuS5FqlcacKX+uUam3I=
=z7Tn
-----END PGP SIGNATURE-----

--=.OUXSHk54?x(Uu+--
