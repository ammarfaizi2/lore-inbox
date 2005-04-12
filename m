Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVDLBEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVDLBEZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 21:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVDLBEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 21:04:25 -0400
Received: from vsmtp12.tin.it ([212.216.176.206]:37804 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S261990AbVDLBEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 21:04:16 -0400
Message-ID: <425B1E3F.5080202@tin.it>
Date: Mon, 11 Apr 2005 20:02:55 -0500
From: "Franco \"Sensei\"" <senseiwa@tin.it>
Reply-To: Sensei <senseiwa@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de>
In-Reply-To: <20050408190500.GF15688@stusta.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6E7DEAF3214A0C8750DD073C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6E7DEAF3214A0C8750DD073C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> This has nothing to do with versioning.
> 
> You are asking for ABI compatibility between different kernel versions.

The problem is probably misunderstanding about what I intend by version.

> There is no stable ABI between different kernel versions and there will 
> never be one. Please read Documentation/stable_api_nonsense.txt for 
> details.

I've read it.

Assuming the fact that a kernel can be considered stable, my point of
view implies an assumption: kernel and modules are distributed by a
distro, and compiled with the same gcc. Of course, I'm not talking about
different architectures and so on, since I'm talking about something
different, I'm talking about the api involved in the developement. 
Distributions have to use a great care about compiler changes, and it's 
not kernel developers' problem.

A kernel stable 2.X  version should not differ much in the
subversioning (2.X.a ~= 2.X.b). Changing APIs in the kernel can be 
possibly avoided by using a release versioning different from the one 
used now. Structues and exported functions should be almost the same, 
the implementation should be, and of course, must be different: bugs, 
improvements and so on.

I see the point about continuous developement, that's why I'm using 
linux since 97, but I find interesting also the design of a stable 
infrastructure, that can be achieved. A data structure no longer in use 
by anyone, functions being unused for a long time, can be made harmless. 
Providing a binary compatibility makes recompiling all external modules 
(external to the official kernel I mean) not necessary, making life 
easier for any other person using linux (e.g. pwc module for my logitech 
pro 4000 webcam, every new kernel, new module compilation. Stability 
makes in this sense a real big improvement. An example of this care can 
be found in trolltech qt library. I use them since 1.x and it's a really 
good thing assuring the binary compatibility... of course they just 
screw it some day to day :) Everybody can be wrong.

I find it an interesting point anyway. I know there would never be, as 
you said, but I don't find the document you've pointed me to, really 
convincing. Still have doubts...

-- 
Sensei <mailto:senseiwa@tin.it> <pgp:8998A2DB>
        <icqnum:241572242>
        <yahoo!:sensei_sen>
        <msn-id:sensei_sen@hotmail.com>

--------------enig6E7DEAF3214A0C8750DD073C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCWx5C4LBKhYmYotsRAgA7AJ9ejBn6x4ukHZNlj7wLzjzjyWHd8ACdHuak
/R2rY2YoXtApJGJq3VolvQQ=
=11DN
-----END PGP SIGNATURE-----

--------------enig6E7DEAF3214A0C8750DD073C--
