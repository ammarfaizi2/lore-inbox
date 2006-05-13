Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWEMAUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWEMAUW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 20:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWEMAUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 20:20:21 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:58298 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932065AbWEMAUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 20:20:20 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [patch] smbus unhiding kills thermal management
Date: Sat, 13 May 2006 10:20:10 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       trenn@suse.de, thoenig@suse.de, c-d.hailfinger.devel.2006@gmx.net
References: <20060512095343.GA28375@elf.ucw.cz>
In-Reply-To: <20060512095343.GA28375@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4097161.UV63zBuXxF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200605131020.16077.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4097161.UV63zBuXxF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 12 May 2006 19:53, Pavel Machek wrote:
> Do not enable the SMBus device on Asus boards if suspend
> is used. We do not reenable the device on resume, leading to all sorts

If this is just a symptom of another problem, how about another patch=20
addressing the base issue? Obviously it wouldn't be -stable material, but=20
it's usually better to address the cause instead of the symptoms (or in thi=
s=20
case, 'as well as').

Regards,

Nigel

--nextPart4097161.UV63zBuXxF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEZSZAN0y+n1M3mo0RAt6KAKDDroJWBx2jid/OP6LOSzCZCYnjWgCfQ91J
xhmIwUbQ3UUIFTJZMobphOQ=
=xB6y
-----END PGP SIGNATURE-----

--nextPart4097161.UV63zBuXxF--
