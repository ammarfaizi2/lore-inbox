Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRAJXqe>; Wed, 10 Jan 2001 18:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129933AbRAJXqZ>; Wed, 10 Jan 2001 18:46:25 -0500
Received: from air.lug-owl.de ([62.52.24.190]:39180 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S129584AbRAJXqK>;
	Wed, 10 Jan 2001 18:46:10 -0500
Date: Thu, 11 Jan 2001 00:46:07 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Which driver took effect?
Message-ID: <20010111004606.B14039@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010110210244.FPCE3141.amsmta01-svc@[192.168.2.2]>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010110210244.FPCE3141.amsmta01-svc@[192.168.2.2]>; from tnvander@chello.nl on Thu, Jan 11, 2001 at 12:33:22AM +0330
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2001 at 12:33:22AM +0330, tnvander@chello.nl wrote:
> Hello,
>=20
> I looked at some outputs and=20
> /proc/interrupts
> /proc/ioports
> /proc/iomem

It's all messy and inconsistent;(

> And scanning dmesg is indeed just the road to ugly hacks, although
> it does seem common practice to report as <interface:drivername at ...>
> so that perhaps an interface name can be linked to a drivername and

Well, some do it that way;)

> both can be used to scan thru /proc/ioports and /proc/interrupts...
> Yes, sounds terribly hacky, sounds like perl or python are wanted
> for this, sounds like a job too large for a bootdisk...

Getting the base IO address is no problem:

/sbin/ifconfig eth0 | grep "Base address" | cut -f 3 -d ':'

=2E..but getting the appropriate driver is not that easy;(

> I'm sorry that I can't help you! I thought that /proc/interrupts
> etc was good advice and then found out that it's as messy :-(

That's just what I thought;)

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpc9D4ACgkQHb1edYOZ4btpXgCdE4PSRkSvrCGKfg8Kf21EdwbY
waAAn17ai8ngehGcqMDP5jYcoENnRXxT
=Z5qC
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
