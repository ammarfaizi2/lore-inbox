Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269553AbUICBnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269553AbUICBnn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269540AbUICBkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:40:25 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:40119 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S269532AbUICBjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:39:33 -0400
Message-ID: <4137CB47.1070805@slaphack.com>
Date: Thu, 02 Sep 2004 20:39:19 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Oliver Neukum <oliver@neukum.org>, Spam <spam@tnonline.net>,
       Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org> <4136E0B6.4000705@namesys.com> <1117111836.20040902115249@tnonline.net> <200409021309.04780.oliver@neukum.org>            <4137BE36.5020504@slaphack.com> <200409030118.i831IUc6006797@turing-police.cc.vt.edu>
In-Reply-To: <200409030118.i831IUc6006797@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu wrote:
| On Thu, 02 Sep 2004 19:43:34 CDT, David Masover said:
|
|
|>And on apps.  Should I teach OpenOffice.org to do version control?
|>Seems a lot easier to just do it in the kernel, and teach everything to
|>do version control in one fell swoop.
|
|
| Including files you didn't really want to keep version control of?

No one said you have to apply it to everything.  Only that you can.
Right now vim cannot do version control, AFAIK.  But you could do
something like:
	echo 1 > foo/version_control
	vim foo

Default would be off, of course.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTfLR3gHNmZLgCUhAQKybRAAkF4sqLUCJEfpDNvKEyv8MJGcy0w+qV12
3Rf50OQeeurZMZrnli0vNIuSIWwIsGI+j7qbj1mlfi+Ps3dAjOlKXav3tGoGshLl
HH/Wl9XvGPOAWlIQOqqBGAyno8sDIvHAjh5lH3C7m+9/2Ao7s1G/bQ+hm/deYPJK
WPZxExd/1BdchrbjNjbfWHKrD6LdF/GBa/Vbj1F8m95WEvxsfbDnSTwb5HhvcUxD
TtqwkINmx7Tle2p9q7PcgR7y76dmcyoWw82ST3BfF/AbGauMQAr0h6jNjvzclfgJ
yrIOwGXdR3pn8ZK8dHVct79N0f+PYFdeAzLYxMZR2vefB2enQolbbs6Lf7X60g2g
5hrH/ezenFJIZMPhQtlJqBaFuA5GHw9B2An6VbOmDm7sSOFyHSlKoCUFlJ/I5nZd
Bcn46lhNxvTJhu3tvnvDqTB8f0/yVYt5QfoBFA1mzHKig2iNN6vr2xLGdWSLU6XD
vRjy+KyVC+PvjL13E0JrjXy9UuqY7CH2xAunSgLJ2cvfRmNRoVoV1hkp3McQcUqF
GiD3s0REcztlvsrP+DxKLRtPpnOJi5By5NmZpJkiPdVB9zpIsL/Ia7KL/A7IGGh3
IF3t/xSUmjgrek01SeadHqsIngeWQ+F8fiars7NtzNhrvRgPVfDVheey3vhQjFxM
3kDKH+I9rGk=
=3+nq
-----END PGP SIGNATURE-----
