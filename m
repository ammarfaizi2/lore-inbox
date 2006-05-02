Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWEBXg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWEBXg4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 19:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWEBXg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 19:36:56 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:16064 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964838AbWEBXgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 19:36:54 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC] kernel facilities for cache prefetching
Date: Wed, 3 May 2006 09:36:12 +1000
User-Agent: KMail/1.9.1
Cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
References: <20060502075049.GA5000@mail.ustc.edu.cn> <20060502191000.GA1776@elf.ucw.cz>
In-Reply-To: <20060502191000.GA1776@elf.ucw.cz>
Organization: Suspend2.net
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1353462.ClRh9Erbfq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200605030936.18606.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1353462.ClRh9Erbfq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 03 May 2006 05:10, Pavel Machek wrote:
> Could we use this instead of blockdev freezing/big suspend image
> support? It should permit us to resume quickly (with small image), and
> then do readahead. ... that will give us usable machine quickly, still
> very responsive desktop after resume?

Unrelated to bdev freezing, and will involve far more seeking than reading =
a=20
contiguous image (as they normally are).

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1353462.ClRh9Erbfq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEV+zyN0y+n1M3mo0RAnPAAJ9Bl+a0HcDUX7Z4KEO3zfmmLHAMFgCdFLC7
UFrF8dVkiCtdBbxD4Zm4Ce0=
=DcZG
-----END PGP SIGNATURE-----

--nextPart1353462.ClRh9Erbfq--
