Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbUDQTat (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 15:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264028AbUDQTat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 15:30:49 -0400
Received: from dialin-212-144-168-054.arcor-ip.net ([212.144.168.54]:13260
	"EHLO karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S264023AbUDQTak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 15:30:40 -0400
In-Reply-To: <20040417183219.GB3856@flea>
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <1082084048.7141.142.camel@lade.trondhjem.org> <20040416045924.GA4870@linuxace.com> <1082093346.7141.159.camel@lade.trondhjem.org> <pan.2004.04.17.16.44.00.630010@smurf.noris.de> <1082225747.2580.18.camel@lade.trondhjem.org> <20040417183219.GB3856@flea>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3-842083795"
Message-Id: <A7E7103A-90A1-11D8-833E-000A958E35DC@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Daniel Egger <degger@fhm.edu>
Subject: Re: NFS and kernel 2.6.x
Date: Sat, 17 Apr 2004 21:01:38 +0200
To: Marc Singer <elf@buici.com>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-3-842083795
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 17.04.2004, at 20:32, Marc Singer wrote:

> I'd be glad to compare TCP to UDP on my system.  It's using an nfsroot
> mount.  It looks like the support is there.  What activates it?

You need to add at least tcp as parameter to the nfsroot boot option,
like nfsroot=1.1.1.1:/tftpboot/foo,tcp,v3 .

And, of course, if you mount/remount NFS partitions you also need to
specify the tcp parameter in your fstab.

Servus,
       Daniel

--Apple-Mail-3-842083795
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQIF/EjBkNMiD99JrAQJ11wgAmkWlhIe9MPjtaEpuuIUzIuxyE5nT2MoJ
9pyYNExFmS6K6ZNmYa9J4OxHIITeMGkJ2TjERoqWhgZ7QMh8FF6RYd2nfk4Fs1fk
lZWXj58dcB7sUBzblqeMMGG5Pav0FsgS8L7hWlXigKYspePcCAiYU1J0tcjA/HU4
9iOaTnHzeiXOzM5QDFTMWKNO6oznBbySX90FtPTaRb3zw+wcLlIQAgz0TJf6rlq+
eg9qvai6R+/5G4/YYx8+FxqllNpbB8XeGsmmqgr5Wq6uUsr2LoAWiZbbV/YKOsw3
eGnE10GgLi1CT56qfEon3p+0yHHh00Ewwb8bBQqeftKOCgZ9UBhM8Q==
=ZlTF
-----END PGP SIGNATURE-----

--Apple-Mail-3-842083795--

