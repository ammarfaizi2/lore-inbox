Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267893AbUI1Uxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267893AbUI1Uxj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 16:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267918AbUI1Uxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 16:53:38 -0400
Received: from ns.schottelius.org ([213.146.113.242]:36992 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S267893AbUI1Uuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 16:50:50 -0400
Date: Tue, 28 Sep 2004 22:54:44 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nico Schottelius <nico-kernel@schottelius.org>,
       Paulo Marques <pmarques@grupopie.com>,
       Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] add sysfs attribute 'carrier' for net devices - try 2.
Message-ID: <20040928205444.GB1496@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Jesper Juhl <juhl-lkml@dif.dk>,
	Stephen Hemminger <shemminger@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Paulo Marques <pmarques@grupopie.com>,
	Martin Waitz <tali@admingilde.org>
References: <Pine.LNX.4.61.0409270041460.2886@dragon.hygekrogen.localhost> <1096306153.1729.2.camel@localhost.localdomain> <Pine.LNX.4.61.0409281316191.22088@jjulnx.backbone.dif.dk> <Pine.LNX.4.61.0409282118340.2729@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0409282118340.2729@dragon.hygekrogen.localhost>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I am just a bit tired and a bit confused, but

Jesper Juhl [Tue, Sep 28, 2004 at 09:23:25PM +0200]:
> > > Using snprintf in this way is kind of silly. since buffer is PAGESIZE.
> > > The most concise format of this would be:
> > > 	return sprintf(buf, dec_fmt, !!netif_carrier_ok(dev));

wouldn't this potentially open a security hole / buffer overflow?

I am currently not really seeing where buf is passed from and what
dec_fmt is, but am I totally wrong?

Nico

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQVnPkbOTBMvCUbrlAQKvLA/9GPCBSithTY94koRSeTy3a2btCUuzfJk9
orofD+qvm9cERu5SHJX4dgcoNfg+fOCXOd/UsT8/1bI437RIdxZOldJd8zcIVV1/
8lEMlFEEZTtRqulbWX58MNVWr40PLhSwdYnxRX416Un+E7aBxDmAZ+/mT3ZbZPMu
/UP8xcPMQ+8/LaAVCto54ErsUu1CBBleMq6C4ElxdtwDtz2aDcJyTPZWqVxwXMwk
qhLxFVfoWvKYeAv2PXMkvRXZXNEiSiOn2K5OomG2ulAVwJ2vYKpulbx26JSdtEYj
3HDc0rbSKSeW48gkOGjEwv67cTyNzNInVu/9NzCtGRZs5x4lcEd6KjrzG2G9xfQZ
70FmW3NcoSVKUOImGRtRvJysSajn7/sGp3D759XPzKmrPlIHK0OqxEtz5Zc3UjWW
OPX8xD/qeuf7PgfN8zGf2BRvd+EvEOwPg6loVLC6l1/XRMsynDxxkovBCg5ccuXO
+HXH4Vb6AMFYzX2EOZULE/rAZLb5V5poZ0oveFYheLvM7s0jn310NG7dGDRXfAXZ
knqmjTAwCZYmoHVG6vtaxr77/O56CyK9JIStOC55hAK/VFSSPTJVIpoTSYFA/j5a
2QsfiZnH7ni5/QJlNCvT5VN/HD3kcyp3ePM4HU9CpvOb4r0rJh1YHZDlttPmVMpU
KvFD6mmuAdE=
=RsXg
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
