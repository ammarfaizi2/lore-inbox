Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTKLJVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 04:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTKLJVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 04:21:47 -0500
Received: from [161.53.89.100] ([161.53.89.100]:32455 "EHLO www3.purger.com")
	by vger.kernel.org with ESMTP id S261898AbTKLJVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 04:21:44 -0500
Date: Wed, 12 Nov 2003 09:01:19 +0100
From: Vid Strpic <vms@bofhlet.net>
To: Berke Durak <obdk65536@ouvaton.org>, linux-kernel@vger.kernel.org
Subject: Re: ide-scsi: "Sleeping function called from invalid context", 2.6.0-test9
Message-ID: <20031112080119.GD21265@home.bofhlet.net>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	Berke Durak <obdk65536@ouvaton.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.0-test9
X-Editor: VIM - Vi IMproved 6.2 (2003 Jun 1, compiled Sep 18 2003 13:09:52)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
X-Face: -|!t[0Pql@=P`A=@?]]hx(Oh!2jK='NQO#A$ir7jYOC*/4DA~eH7XpA/:vM>M@GLqAYUg9$ n|mt)QK1=LZBL3sp?mL=lFuw3V./Q&XotFmCH<Rr(ugDuDx,mM*If&mJvqtb3BF7~~Guczc0!G0C`2 _A.v7)%SGk:.dgpOc1Ra^A$1wgMrW=66X|Lyk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2003 at 04:30:41PM +0100, Berke Durak wrote:
> I get a kernel problem while using cdrecord to write audio to a blank
> CD-R.
> This happens with 2.6.0-test6 and 2.6.0-test9 with kernel
> preemptibility enabled.
> The distribution is a Debian 3.0r1/testing.
> Kernel output, cdrecord output and dmesg follows.

[...]

Oh wonderful.  It has happenned to me, too, test9, Slackware 9.1,
cdrecord 2.0a19 (same as yours).  I think there's a problem with DMA -
it wasnt' enabled when this happened.  When I enabled it, CD's burned
normally.  And this happened only when I built SCSI support (sg, sr_mod)
as modules.. when in core, DMA is enabled automatically and _stays_
enabled...

--=20
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux moria 2.6.0-test9 #1 Sat Oct 25 23:00:37 CEST 2003 i686
 08:58:05 up 6 days, 18:15,  1 user,  load average: 0.24, 0.30, 0.22
I am Chevy Chase of Borg, and you're not.

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/sejOq1AzG0/iPGMRAsh5AJwI062P/f3DU9Ns71/gw5EW5wkKxQCgq5tQ
cWKTEhLe8xt7Crq9TEZEbKM=
=ZDUN
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
