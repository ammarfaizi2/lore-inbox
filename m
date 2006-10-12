Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422766AbWJLG56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422766AbWJLG56 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 02:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422769AbWJLG56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 02:57:58 -0400
Received: from lug-owl.de ([195.71.106.12]:40612 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1422766AbWJLG54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 02:57:56 -0400
Date: Thu, 12 Oct 2006 08:57:54 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: John Wendel <jwendel10@comcast.net>
Cc: Eric Sandeen <esandeen@redhat.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       Jan Kara <jack@suse.cz>, Eric Sandeen <sandeen@sandeen.net>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
Message-ID: <20061012065754.GJ31823@lug-owl.de>
Mail-Followup-To: John Wendel <jwendel10@comcast.net>,
	Eric Sandeen <esandeen@redhat.com>,
	Badari Pulavarty <pbadari@us.ibm.com>, Jan Kara <jack@suse.cz>,
	Eric Sandeen <sandeen@sandeen.net>, Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061010141145.GM23622@atrey.karlin.mff.cuni.cz> <452C18A6.3070607@redhat.com> <1160519106.28299.4.camel@dyn9047017100.beaverton.ibm.com> <452C4C47.2000107@sandeen.net> <20061011103325.GC6865@atrey.karlin.mff.cuni.cz> <452CF523.5090708@sandeen.net> <20061011142205.GB24508@atrey.karlin.mff.cuni.cz> <1160589284.1447.19.camel@dyn9047017100.beaverton.ibm.com> <452DAA26.6080200@redhat.com> <452DC5C5.3040507@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ah40dssYA/cDqAW1"
Content-Disposition: inline
In-Reply-To: <452DC5C5.3040507@comcast.net>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ah40dssYA/cDqAW1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-10-11 21:34:13 -0700, John Wendel <jwendel10@comcast.net> wrot=
e:
> Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5): ext3_free_b=
locks_sb: bit already cleared for block 4740550
> Oct 11 20:37:32 Godzilla kernel: Aborting journal on device hda5.
> Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5) in ext3_free=
_blocks_sb: Journal has aborted
> Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5) in ext3_free=
_blocks_sb: Journal has aborted
> Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5) in ext3_rese=
rve_inode_write: Journal has aborted
> Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5) in ext3_trun=
cate: Journal has aborted
> Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5) in ext3_rese=
rve_inode_write: Journal has aborted
> Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5) in ext3_orph=
an_del: Journal has aborted
> Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5) in ext3_rese=
rve_inode_write: Journal has aborted
> Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5) in ext3_dele=
te_inode: Journal has aborted
> Oct 11 20:37:32 Godzilla kernel: __journal_remove_journal_head: freeing b=
_committed_data
> Oct 11 20:37:32 Godzilla kernel: __journal_remove_journal_head: freeing b=
_committed_data
> Oct 11 20:37:32 Godzilla kernel: ext3_abort called.
> Oct 11 20:37:32 Godzilla kernel: EXT3-fs error (device hda5): ext3_journa=
l_start_sb: Detected aborted journal
> Oct 11 20:37:32 Godzilla kernel: Remounting filesystem read-only

This looks very much like the issue I see.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:                http://catb.org/~esr/faqs/smart-questions.html
the second  :

--Ah40dssYA/cDqAW1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFLedyHb1edYOZ4bsRAloIAKCEKHY5xPsdEzassLoIiyXKcEHzHACdGSne
xgKYCMLyI75ojlB7aEYq0a8=
=r5UU
-----END PGP SIGNATURE-----

--Ah40dssYA/cDqAW1--
