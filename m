Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWGXIIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWGXIIA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 04:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWGXIIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 04:08:00 -0400
Received: from nsm.pl ([195.34.211.229]:45832 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S932091AbWGXIH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 04:07:59 -0400
Date: Mon, 24 Jul 2006 10:07:52 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Can't clone Linus tree
Message-ID: <20060724080752.GA8716@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


 Hi,

 yesterdat I wanted to bisect my kernel problem, but failed at first step:
cloning Linus' tree. Today I tried it on other system and also failed.

 This is git-1.4.0 on Slackware, i586:

%  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2=
=2E6.git linux-git
fatal: packfile '/home/zdzichu/linux-git/.git/objects/pack/tmp-1jI4AH' SHA1=
 mismatch
error: git-fetch-pack: unable to read from git-index-pack
error: git-index-pack died with error code 128
fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux-2.6.git' failed.

 And this is 1.4.0-1.fc5 on FC5, x86_64:
% git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.=
6.git linux-git
fatal: packfile '/home/tomek/linux-git/.git/objects/pack/tmp-BxIcIC' SHA1 m=
ismatch
error: git-fetch-pack: unable to read from git-index-pack
error: git-index-pack died with error code 128
fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux-2.6.git' failed.

 Errors occur constantly since yesterday. They of course appear after
downloading several megabytes of data, which is unpleasant on my 128kbps
connection.

--=20
Tomasz Torcz                 "God, root, what's the difference?"
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."


--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFExH/YThhlKowQALQRAgwdAKCz+I1zR6YCQK1p1oZqV0SVC8HJYACfZSu6
NdcV//zigPrEOsKv7b2lXBk=
=ioDu
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
