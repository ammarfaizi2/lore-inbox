Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbULFL1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbULFL1P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 06:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbULFL1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 06:27:15 -0500
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:49875 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261503AbULFL1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 06:27:03 -0500
Message-ID: <41B441FD.7050709@kolivas.org>
Date: Mon, 06 Dec 2004 22:26:53 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: krishna <krishna.c@globaledgesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How can we change the priority of a kernel thread .
References: <41B42E39.6030001@globaledgesoft.com>
In-Reply-To: <41B42E39.6030001@globaledgesoft.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig76EADC870134B412BEDF39DF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig76EADC870134B412BEDF39DF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

krishna wrote:
> Hi all,
> 
> I have a situation, where the kernel thread has to run with more 
> priority to avoid spikes in chariot.
> Does any know how to do this.

renice or schedtool work fine when you're root.

Cheers,
Con

--------------enig76EADC870134B412BEDF39DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBtEH9ZUg7+tp6mRURApKuAKCHzV2S9ldJEUkdlDFwMX7VdPZc6ACfXMUj
E3gBZMytqW8rYzDs0XkS2J0=
=MXTj
-----END PGP SIGNATURE-----

--------------enig76EADC870134B412BEDF39DF--
