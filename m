Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264708AbUD1JYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264708AbUD1JYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 05:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264709AbUD1JYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 05:24:35 -0400
Received: from dialin-212-144-167-035.arcor-ip.net ([212.144.167.35]:6813 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S264708AbUD1JYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 05:24:33 -0400
In-Reply-To: <20040427144922.43436.qmail@web41203.mail.yahoo.com>
References: <20040427144922.43436.qmail@web41203.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-20--391195354"
Message-Id: <343EBB2A-98F2-11D8-B40E-000A958E35DC@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Daniel Egger <degger@fhm.edu>
Subject: Re: PROBLEM: memory managment bug in kernel >= 2.4.23
Date: Wed, 28 Apr 2004 10:58:23 +0200
To: Pierre Berthier <berthierp@yahoo.com>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-20--391195354
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 27.04.2004, at 16:49, Pierre Berthier wrote:

>> every two minutes a "__alloc_pages: 0-order allocation failed
>> (gfp=0x21/0)"
>> message.

> I have discovered that this bug is triggered by doing a 'cat
> /proc/scsi/gdth/1'.  I have posted a bug report to linux-scsi.

No such hardware here, so this might as well be different bug
which is also exposed by the proc filesystem.

Servus,
       Daniel

--Apple-Mail-20--391195354
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQI9yLzBkNMiD99JrAQL/NAgAh2V9WnWxsKsSuQKLOtoQvCT8e8zJzd+b
t3ysK4YduBbcz53LMTyNk2TOmS3NipINeKJ11d9oRa1l4iMk9z1goWHqcF0Ieuhg
RwLIqp0xy2NSBFkvp8hdF/3WhqfgiK35KajaPqC1S18K+vj2PLs0UuPq4gkxvgeh
VFToDrMYfJA1o835iDOU+UNrduUHebg2Po+7e68wM8HEIzDXwfMz9nKYq/gQ+2VL
ZDwmqqKja4QaSxumaAkHDGJvOBCh0wCqAp0tKaw4FUqK8dDZio+XcvZi6sASlJLa
LzvThlXPLqo8L2rwVzBgEXAlmfnmpKN/9dEVDuujuBuSM5MRQxJCOg==
=e5xA
-----END PGP SIGNATURE-----

--Apple-Mail-20--391195354--

