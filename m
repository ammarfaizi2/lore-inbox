Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUHaBOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUHaBOp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 21:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUHaBOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 21:14:45 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:48295 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S266048AbUHaBOm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 21:14:42 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: TG3(Tigoon) & Kernel 2.4.27
Date: Mon, 30 Aug 2004 18:14:38 -0700
User-Agent: KMail/1.7
References: <412B5B35.7020701@apartia.fr> <20040825044551.GH1456@alpha.home.local> <20040824233648.53eb7c30.davem@redhat.com>
In-Reply-To: <20040824233648.53eb7c30.davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1509679.xpAGbF2qz9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408301814.41346.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1509679.xpAGbF2qz9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 24 August 2004 23:36, you wrote:
> I pity the poor fool who wishes to netboot his system using
> a tg3 card and use an nfsroot with Debian.  Kind of hard to
> get the card firmware from the filesystem in that case.
initramfs?

> The tg3 firmware is just a bunch of MIPS instructions.
> I guess if I ran objdump --disassemble on the image and
> used the output of that in the tg3 driver and "compiled
> that source" they'd be happy.  And this makes the situation
> even more ludicrious.
=46or GPL compliance, no, that wouldn't work. The GPL states:
"The source code for a work means the preferred form of the work for making=
=20
modifications to it."

Which is likely C or at least assembly with label names and comments in thi=
s=20
case.

=2DRyan

--nextPart1509679.xpAGbF2qz9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBM9EBW4yVCW5p+qYRApXnAJ4tknoPxoHvDLhJfTEVMh2LMwdjJgCfbtt5
xa0o1TFKTQ1WLlxojgN3g/w=
=hwTH
-----END PGP SIGNATURE-----

--nextPart1509679.xpAGbF2qz9--
