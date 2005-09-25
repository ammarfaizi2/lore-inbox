Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVIYKOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVIYKOf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 06:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVIYKOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 06:14:35 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:42634 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751247AbVIYKOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 06:14:34 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use .incbin for config_data.gz
Date: Sun, 25 Sep 2005 12:13:49 +0200
User-Agent: KMail/1.7.2
Cc: Brian Gerst <bgerst@didntduck.org>, Andrew Morton <akpm@osdl.org>
References: <43359B28.1040007@didntduck.org>
In-Reply-To: <43359B28.1040007@didntduck.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2016831.Z6g3jyCG9S";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509251213.56437.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2016831.Z6g3jyCG9S
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Brian,

On Saturday 24 September 2005 20:30, Brian Gerst wrote:
> Instead of creating config_data.h, use .incbin in inline assembly to
> directly include config_data.gz.

Good idea, but please make this .rodata instead of .data,
since this isn't going to be modified.

Regards

Ingo Oeser


--nextPart2016831.Z6g3jyCG9S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDNnhkU56oYWuOrkARAkNTAKCUZaj2ruQwfVYhDhRCkxaxzsMHOACgs10u
EodWX0AxA9mAPXuMqp88JC0=
=zIMH
-----END PGP SIGNATURE-----

--nextPart2016831.Z6g3jyCG9S--
