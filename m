Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUFEOYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUFEOYy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 10:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUFEOYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 10:24:54 -0400
Received: from port-212-202-157-212.reverse.qsc.de ([212.202.157.212]:34489
	"EHLO bender.portrix.net") by vger.kernel.org with ESMTP
	id S261500AbUFEOYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 10:24:52 -0400
Message-ID: <40C1D798.2040406@portrix.net>
Date: Sat, 05 Jun 2004 16:24:24 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Who has record no. of  DriveReady SeekComplete DataRequest
 errors?
References: <200406060007.10150.kernel@kolivas.org>
In-Reply-To: <200406060007.10150.kernel@kolivas.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8D0ED85BBF80C98DEB253D82"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8D0ED85BBF80C98DEB253D82
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> Well since 2.6.3 I think I've been getting the record number of 
> 
> hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> hdd: status error: error=0x00
> hdd: drive not ready for command
> hdd: ATAPI reset complete
> 
> errors from my cdrw on hdd; and it's only one drive's worth.
> 
> 
> dmesg -s 32768 | grep DataRequest | wc -l
> 88

Same count here: (2.6.7-rc1)

$ dmesg -s 65536 | grep DataRequest | wc -l
88

I never bothered to report this, because it just kept working and I was 
shuffling hardware at the same time. Don't really know with which kernel 
release it started. Drive is a sony cdrw on hdc.

Jan

--------------enig8D0ED85BBF80C98DEB253D82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAwdegLqMJRclVKIYRAkInAJ9sUCjJjyORg2LyEoSg+qoZENtXeQCeOP9d
BzgU+Sa9HClRbIp4CxRRyVI=
=B7cD
-----END PGP SIGNATURE-----

--------------enig8D0ED85BBF80C98DEB253D82--
