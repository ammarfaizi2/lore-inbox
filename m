Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318224AbSG3LNC>; Tue, 30 Jul 2002 07:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318222AbSG3LNC>; Tue, 30 Jul 2002 07:13:02 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:18228 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S318221AbSG3LNA>; Tue, 30 Jul 2002 07:13:00 -0400
Date: Tue, 30 Jul 2002 13:16:17 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] sd_many done right (5/5)
Message-ID: <20020730111617.GA1214@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20020726154948.GH19721@nbkurt.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20020726154948.GH19721@nbkurt.etpnet.phys.tue.nl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2002 at 05:49:48PM +0200, Kurt Garloff wrote:
> The patch is against 2.4.19-rc1 with patch 1/5 (and optionally 2--4)=20
> applied. You will want to apply patch 4/5 (partition statistics) in order
> to avoid significant consumption of memory when using many disks.

Christoph Hellwig made me aware that the diff was not applying cleanly. Thx!
The reason was that I had the aa patches in my trees.
I rediffed against a clean rc3. New patches are available on
http://www.suse.de/~garloff/linux/scsi-many/

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9RnWBxmLh6hyYd04RAqj+AJ49a2+8QnpQCsQtyR/C1lAzWg+VWgCbBN8D
KkFpc0bOwZ1O+0EHrvdr6PY=
=RRzh
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
