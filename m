Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUFQTsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUFQTsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUFQTsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:48:14 -0400
Received: from dialin-212-144-167-148.arcor-ip.net ([212.144.167.148]:64457
	"EHLO karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S262382AbUFQTsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:48:01 -0400
In-Reply-To: <40D1D2F0.7080102@namesys.com>
References: <40D1B110.7020409@leesburg-geeks.org> <40D1C18B.1030907@techsource.com> <40D1D2F0.7080102@namesys.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-61--327439678"
Message-Id: <A5938B92-C096-11D8-AAF6-000A958E35DC@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org,
       pla@morecom.no, Ken Ryan <linuxryan@leesburg-geeks.org>
From: Daniel Egger <degger@fhm.edu>
Subject: Re: mode data=journal in ext3. Is it safe to use?
Date: Thu, 17 Jun 2004 21:43:46 +0200
To: Hans Reiser <reiser@namesys.com>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-61--327439678
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 17.06.2004, at 19:20, Hans Reiser wrote:

> Actually, most compact flash devices DO do wear leveling, from what I 
> have heard.

Care to mention sources? I'd be surprised if they did simply because
it'll cost money that could be earned otherwise. Also I think you
confuse bad block remapping with wear leveling and even the former
I haven't experienced so far.

CF disks were designed for simply the reason of having an empty disk,
writing data onto it up to a certain level, reading it a few times
and emptying the disk again. So except for the organizational blocks
and "the end" of a disk which tends to get rarely hit there're a
well distributed write utilization.

Servus,
       Daniel

--Apple-Mail-61--327439678
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQNH0cjBkNMiD99JrAQJjtQf/cjf3LGZ0TLdIZ21O70GtwW9h/6gThSXf
bqNd9tpljinoLKJ8U5vqd2OBp86rE8TrrFjyV/z1YIwM6vz3nuDejo7rWv3nmYZa
4xH/yHtC5B48FQhfuIKW928zAoySosaCAtD7kQy7fnTYBDnNN0NcHqjDmOkth+tN
VBEbEzOvEJGHY+cvV0aFjlHejrOQM4lrg1py7qcBTgw0tKp6HK1dgVaXGEWSiaQG
IhLqAt04ELm7lBpazg44a7xxUmPILbeEmff5pGbs+4KZ3nyhBsLMhgBt08TRV4hQ
xWnp5ZS+hZWK4tih6O6L+3Xe98ESq7tHZNYUNRvt+UpUjkR5tdC63A==
=h3i4
-----END PGP SIGNATURE-----

--Apple-Mail-61--327439678--

