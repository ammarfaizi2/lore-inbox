Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbUKLSzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbUKLSzt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 13:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbUKLSzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 13:55:48 -0500
Received: from mail.il.fontys.nl ([145.85.127.32]:6384 "EHLO
	mordor.il.fontys.nl") by vger.kernel.org with ESMTP id S262610AbUKLSzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 13:55:40 -0500
From: "Ed Schouten" <ed@il.fontys.nl>
Date: Fri, 12 Nov 2004 19:55:33 +0100
To: Diego <foxdemon@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Some ideas about % of CPU for a process
Message-ID: <20041112185533.GA16907@il.fontys.nl>
References: <d5a95e6d0411121047690a0b51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <d5a95e6d0411121047690a0b51@mail.gmail.com>
X-Message-Flag: Please upgrade your mailreader to Mozilla Thunderbird at http://www.mozilla.org/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Diego,

On Fri 12 Nov 2004 03:47 PM, Diego wrote:
> I'm trying to define a % of cpu for a process, but i don?t have idea
> about how i can do it. For example, i said that my process need 40% of
> CPU during its lifetime, how can i do it in kernel 2.6?
> Thanks for ideas.

Why don't you 'ps' the process and divide the running time through the
starting time?

        time
  ----------------  =3D  average process cpu usage
  (now - started))

Yours,
--=20
 Ed Schouten <ed@il.fontys.nl>
 Website: http://g-rave.nl/
 GPG key: finger ed@il.fontys.nl

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBlQclyx16ydahrz4RAoEMAKDL/epNFM1GJauoFUySMj5nX7BzaACgpuZU
rQL+0M+T3K3BBG0a1lYSylg=
=9b6I
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
