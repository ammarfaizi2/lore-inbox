Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbTF0KM0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 06:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTF0KM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 06:12:26 -0400
Received: from komoseva.globalnet.hr ([213.149.32.250]:39944 "EHLO
	komoseva.globalnet.hr") by vger.kernel.org with ESMTP
	id S264124AbTF0KMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 06:12:24 -0400
Date: Fri, 27 Jun 2003 11:27:08 +0200
From: Vid Strpic <vms@bofhlet.net>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI CDROM and NFS or AI?
Message-ID: <20030627092708.GM20998@home.bofhlet.net>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	Marc Giger <gigerstyle@gmx.ch>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.4.21
X-Editor: VIM - Vi IMproved 6.1 (2002 Mar 24, compiled May  3 2002 20:49:56)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
X-Face: -|!t[0Pql@=P`A=@?]]hx(Oh!2jK='NQO#A$ir7jYOC*/4DA~eH7XpA/:vM>M@GLqAYUg9$ n|mt)QK1=LZBL3sp?mL=lFuw3V./Q&XotFmCH<Rr(ugDuDx,mM*If&mJvqtb3BF7~~Guczc0!G0C`2 _A.v7)%SGk:.dgpOc1Ra^A$1wgMrW=66X|Lyk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2003 at 09:57:28PM +0200, Marc Giger wrote:
> I think my pc got some kind of AI:-) Yesterday I exported the scsi cdrom
> via nfs. Today, its very amusingly, my scsi cdrom opens the drawer
> suddenly. It's surely the fifth times this evening on which I close the
> drawer again 8).
> Is this behavior normal;-) Is my PC bored?
> And No it's not a joke!

I know it isn't ... so, have you `setcd` installed in any case?  If not,
install it, and look:

setcd -s /dev/cdrom
/dev/cdrom:
Auto open tray:      set

If something like this shows, then it's your problem....

Setcd utility is, I think, primary for ATAPI CD-ROM's, but it works on
SCSI too, I just checked ...

--=20
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux lorien 2.4.21 #1 Sat Jun 14 01:23:07 CEST 2003 i586
 11:24:00 up 13 days,  8:05,  9 users,  load average: 0.10, 0.22, 0.23
Muskarci su kao komarci: Ubodu pa odu (grafit u Odeskoj ulici, Split)

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+/A3sq1AzG0/iPGMRAnczAKC8SChOPXTN85zV1AS+kkAxNB7b9ACgsXYf
wfMDXdgQR+cA90g22GYP5AA=
=1XST
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--
