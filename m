Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317861AbSGVW0p>; Mon, 22 Jul 2002 18:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317864AbSGVW0o>; Mon, 22 Jul 2002 18:26:44 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:38405 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S317861AbSGVW0o>; Mon, 22 Jul 2002 18:26:44 -0400
Date: Mon, 22 Jul 2002 23:29:41 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: using bitkeeper to backport subsystems?
Message-ID: <20020722232941.A10083@computer-surgery.co.uk>
References: <20020721233410.GA21907@lukas> <20020722071510.GG16559@boardwalk> <20020722102930.A14802@lst.de> <20020722102705.GB21907@lukas> <20020722152031.GB692@opus.bloom.county>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020722152031.GB692@opus.bloom.county>; from trini@kernel.crashing.org on Mon, Jul 22, 2002 at 08:20:31AM -0700
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2002 at 08:20:31AM -0700, Tom Rini wrote:
> Possibly, once bitkeeper allowes ChangeSets to only depend on what they
> actually need, not every previous ChangeSet in the repository.  IIRC,
> this was one of the things Linus asked for, so hopefully it will happen.

While that would be great.

With all due respect to Larry and the bk team, I think you'll
find determining 'needed changesets' in this case is a _hard_ problem.

How is bk supposed to find that a change depends on a previously
redefined api declared in a set of files othwerwise untouched by the=20
changeset being exported.

Now , bk could make this a little easier by allowing changesets to
be exported without any dependencies (ala GNU-patch export - but
with metadata for commit messages).

The developer can then use a 'bk undo'  to remove the unnessary changeset
for his patch , reapply keeping the commit metadata, test and now
re-export a full bk patch with minimal dependencies.

Unfortuantely I know know way of currently instructing bk to
do this dependency-less export.

--
TTFN
Roger.
Master of Peng Shui.  (Ancient oriental art of Penguin Arranging)
GPG Key FPR: CFF1 F383 F854 4E6A 918D  5CFF A90D E73B 88DE 0B3E

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9PIdUqQ3nO4jeCz4RAsRhAKCC/Kpz15sxc6NyTT38NXAKlzExswCfWrBE
SzAjmbBHkS1b/k02dvKv9Qw=
=vLfB
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
