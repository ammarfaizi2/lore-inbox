Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVCHVYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVCHVYA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 16:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVCHVYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 16:24:00 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:37255 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S262359AbVCHVWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 16:22:44 -0500
Date: Tue, 8 Mar 2005 22:18:49 +0100
From: Jan Hudec <bulb@ucw.cz>
To: Weber Matthias <weber@faps.uni-erlangen.de>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Writing data > PAGESIZE into kernel with proc fs
Message-ID: <20050308211849.GA20626@vagabond>
References: <09766A6E64A068419B362367800D50C0B58A4F@moritz.faps.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <09766A6E64A068419B362367800D50C0B58A4F@moritz.faps.uni-erlangen.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 08, 2005 at 20:05:42 +0100, Weber Matthias wrote:
> is there any chance to signal an EOF when writing data to kernel via proc fs? Actually if the length of data is N*PAGE_SIZE it seems not to be detectable. I followed up the "struct file" but haven't found anything that helped...

End-of-file is signified by closing the file. As usual.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCLha5Rel1vVwhjGURAo4DAJ9afXHt8DV7v2lfhl5dzIuH7nL3zgCgpuO+
aXpi8GGVd4A1XhT4CNxJZHk=
=UOzj
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
