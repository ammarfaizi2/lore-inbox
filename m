Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbUJXKmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbUJXKmi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 06:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUJXKmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 06:42:38 -0400
Received: from mra04.ex.eclipse.net.uk ([212.104.129.139]:35299 "EHLO
	mra04.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S261432AbUJXKjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 06:39:18 -0400
From: Alastair Stevens <alastair@altruxsolutions.co.uk>
Organization: Haverhill UK
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.9-ck1: swap mayhem under UT2004
Date: Sun, 24 Oct 2004 11:38:51 +0100
User-Agent: KMail/1.7
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
References: <200410222346.32823.alastair@altruxsolutions.co.uk> <200410231722.59362.alastair@altruxsolutions.co.uk> <417B1A7F.2020607@yahoo.com.au>
In-Reply-To: <417B1A7F.2020607@yahoo.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5265667.3XsZK3cAkU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410241138.55618.alastair@altruxsolutions.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5265667.3XsZK3cAkU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 24 October 2004 3:59, Nick Piggin wrote:
> Can you try the following patch to start with, please?
> (against 2.6.10-rc1, but should apply to most recent kernels I think)

[vm-pages_scanned-active_list.patch]

Thanks Nick - seems exemplary so far.  No stuttering or swap thrashing=20
under the time-honoured UT2004 test, even with some phat desktop apps=20
sitting in memory.

I'm still running on 2.6.9-ck1 for now.  Is there anything else you want=20
me to try?  Presumably VM scanning work is ongoing for 2.6.10?  I might=20
give -rc1 a spin, just for fun....

Cheers
Alastair

=2D-=20
                                        o
Alastair Stevens : child of 1976       /-'_              LPI (Level 1)
  www.altruxsolutions.co.uk           |\/(*)   /\__     Linux Certified
_________________________________ . .(*) _____/    \___________________
        Ditch IE and ignite a new web - www.getfirefox.com

--nextPart5265667.3XsZK3cAkU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBe4Y/ZaIQ8KuIK+0RAh30AKCkv1sYTQ3/91SXgrxvYXON8frhjgCfUWKz
iXhW3KHOuGslNZI4OWjySUM=
=fR3b
-----END PGP SIGNATURE-----

--nextPart5265667.3XsZK3cAkU--
