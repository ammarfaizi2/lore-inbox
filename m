Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWAHOf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWAHOf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 09:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbWAHOf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 09:35:28 -0500
Received: from [85.8.13.51] ([85.8.13.51]:45250 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751412AbWAHOf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 09:35:28 -0500
Message-ID: <43C12319.2060604@drzeus.cx>
Date: Sun, 08 Jan 2006 15:35:05 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.7-2.1.fc4.nr (X11/20051011)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_hermes.drzeus.cx-19258-1136730917-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org,
       adobriyan@gmail.com
Subject: Re: [PATCH] [MMC] Lindent wbsd driver
References: <20060107231747.29389.80042.stgit@poseidon.drzeus.cx> <20060108142535.GC10927@flint.arm.linux.org.uk>
In-Reply-To: <20060108142535.GC10927@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-19258-1136730917-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Russell King wrote:
> On Sun, Jan 08, 2006 at 12:17:48AM +0100, Pierre Ossman wrote:
> 
>>@@ -1079,9 +1030,9 @@ static int wbsd_get_ro(struct mmc_host* 
>> }
>> 
>> static struct mmc_host_ops wbsd_ops = {
>>-	.request	= wbsd_request,
>>-	.set_ios	= wbsd_set_ios,
>>-	.get_ro		= wbsd_get_ro,
>>+	.request = wbsd_request,
>>+	.set_ios = wbsd_set_ios,
>>+	.get_ro = wbsd_get_ro,
> 
> 
> In addition to Alexey's comments, I think this was better before being
> "reindented".  If you agree, could you produce a new patch please?
> 

I do. I changed what I noticed, but evidently I missed some things. I'll
go over it again and send you a new patch later today.

Rgds
Pierre

--=_hermes.drzeus.cx-19258-1136730917-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDwSMd7b8eESbyJLgRAhvWAJ9KlWncVutR3W5dy8mfJKu5F8ypkgCg+HYX
Jai0Jb2kLsQSavUOhlukwQU=
=EU8V
-----END PGP SIGNATURE-----

--=_hermes.drzeus.cx-19258-1136730917-0001-2--
