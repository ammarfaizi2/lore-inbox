Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbTCIWb1>; Sun, 9 Mar 2003 17:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262649AbTCIWb1>; Sun, 9 Mar 2003 17:31:27 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:57316 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262648AbTCIWb0>; Sun, 9 Mar 2003 17:31:26 -0500
Date: Sun, 9 Mar 2003 23:40:57 +0100
From: Kurt Garloff <garloff@suse.de>
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] work around gcc-3.x inlining bugs
Message-ID: <20030309224057.GC2401@nbkurt>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andi Kleen <ak@suse.de>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <20030306032208.03f1b5e2.akpm@digeo.com.suse.lists.linux.kernel> <p73fzq067an.fsf@amdsimf.suse.de> <20030306212845.GA2292@nbkurt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <20030306212845.GA2292@nbkurt>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.19-UL1 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 06, 2003 at 10:28:45PM +0100, Kurt Garloff wrote:
> The fact that this parameter does not get initialized by using
> -finline-limit is a bug. A fix for this has already gone into CVS HEAD
> (3.4) and is pending for 3.3.

Patch has been applied to 3.3 as well now.
Thanks to Geoff Keating and Dale Johannesen.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers                 SuSE Labs (Head)
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQE+a8L4xmLh6hyYd04RArMsAKC2xUG9pbxCvTJDpZgAghiIFjNZNwCfWZBL
AJd3bPsk+hq0n3Np/ngoFWk=
=wYS4
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
