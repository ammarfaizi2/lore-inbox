Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbSLaHsC>; Tue, 31 Dec 2002 02:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267185AbSLaHsC>; Tue, 31 Dec 2002 02:48:02 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:992
	"EHLO localhost") by vger.kernel.org with ESMTP id <S262602AbSLaHsA>;
	Tue, 31 Dec 2002 02:48:00 -0500
Date: Mon, 30 Dec 2002 23:55:37 -0800
From: Joshua Kwan <joshk@ludicrus.ath.cx>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA and hermer/orinoco_cs drivers b0rken?
Message-Id: <20021230235537.1aa44cae.joshk@ludicrus.ath.cx>
In-Reply-To: <878yy6zqrz.fsf@lapper.ihatent.com>
References: <87u1h3fim2.fsf@lapper.ihatent.com>
	<20021226003405.014f0638.joshk@mspencer.net>
	<87u1gwuomh.fsf@lapper.ihatent.com>
	<20021230085529.GA12575@localhost>
	<878yy6zqrz.fsf@lapper.ihatent.com>
X-Mailer: Sylpheed version 0.8.8claws26 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.2qt4q/jSg.p3Hc"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.2qt4q/jSg.p3Hc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> Any benefit of using an AP over an ad-hoc network if it's only two or
> three nodes in a room?

Well, the benefit of an AP is slightly more symmetrical and wide
coverage(I _____think_____ - someone PLEASE correct me because I'm quite
unsure) and the range of an ad-hoc network is dependent on the number of
nodes.

So in, like, a living room, Ad-Hoc is probably just as good as using an
AP. But there's really no real advantage between the two. In my
experience using Ad-Hoc I have gotten faster TX rates, mostly because
there's no middle-man.

Still, it's up to you. If you were planning to shell out for an AP I
suggest you just set up a lowend Linux box with hostap driver
(http://hostap.epitest.fi) and use that (add iptables for internet
access, or whatever you like). cheaper and in some cases better.

Regards
-Josh

Rabid cheeseburgers forced Alexander Hoogerhuis<alexh@ihatent.com> to
write this on 31 Dec 2002 06:44:16+0100:	

> "Joshua M. Kwan" <joshk@ludicrus.ath.cx> writes:
> 
> > > Warning: Driver for device eth1 has been compiled with version 14
> > > of Wireless Extension, while this program is using version 13.
> > > Some things may be broken...
> > 
> > First of all, what kernel are you using? That's an ancient version
> > of the WE. If this is 2.4.2[01], download the following diffs from
> > Jean's fine site:
> > 
> > *
> > http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/iw240_we15-6.diff
> > *
> > http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/iw241_we16-3.diff
> > 
> 
> No warnings anymore, and it all works. I now have a full 2 yards of
> wireless netowrk and dont have to run a cat5 over to muy couch :)
> 
> Apart from that, Jean Tourrilhes' site was a treasure of HOWTOs and
> FAQs, so I'll spend a lot of time reading up there. Next thing up is
> bluetooth, and the site seems to be the right place for that, too.
> 
> > Next of all, try upgrading the firmware on your card.
> > 
> 
> Went trough the motions of finding NetGears support on this. NetGear
> now officially has landed on my list of gear not to recommend. The
> while sitiation on finding firmware and tools to flash it didn't
> strike me as very orderly, and I ended up using some Dlink tools I
> found through Google to get my card slightly upgraded, but it seemed
> to do the trick. The other Lucent/Orinoco card I had was more simple
> and done in a few minutes.
> 
> > The error writing packet to BAP error always seemed just like a
> > small nuisance to me during large file transfers. It did not
> > correlate with any connectivity problems, so I just commented it out
> > in the orinoco/hermes/orinoco_cs source (it's in one of those
> > files.)
> > 
> 
> I never got to try it on large files, I had a few dozen errors from a
> card idling with no connectivity :)
> 
> > Hope your wireless endeavors succeed - I just spent all week getting
> > hostap_plx to work (and I'm now reaping the benefits because I now
> > have wifi access all over my house) :)
> > 
> 
> Any benefit of using an AP over an ad-hoc network if it's only two or
> three nodes in a room?
> 
> > Regards
> > -Josh
> > 
> 
> mvh,
> A
> -- 
> Alexander Hoogerhuis                               | alexh@ihatent.com
> CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
> "You have zero privacy anyway. Get over it."  --Scott McNealy
> 


-- 
Joshua Kwan
joshk@mspencer.net
pgp public key at http://joshk.mspencer.net/pubkey_gpg.asc
 
Much of the excitement we get out of our work is that we don't really
know what we are doing.
		-- E. Dijkstra

--=.2qt4q/jSg.p3Hc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+EU166TRUxq22Mx4RAt0jAJ9Dagqvio8K1KN1o0EgqQ5h9hJfjwCfVrtB
6q3s1OSSECdzrLCnWi0VrYk=
=V1qv
-----END PGP SIGNATURE-----

--=.2qt4q/jSg.p3Hc--
