Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbVG2U0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbVG2U0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbVG2U0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:26:05 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:59193 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262814AbVG2UYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:24:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=Cmq34G3hM/XE5xxIdvqdqNJhGmdCYbkAiquA9jkt19Lal0hWrRzdOQ37qYPGEp4Fl2qoCnEm4A9MWBeeS/2aBoLnx0i0cs6x75nxafrDEVLLIl7HFawSRcJc4BurTcv9v3qC/uqyTMfE9DrNPzMSk9E2QaspNmUvMHrDkYyyAi8=
From: Rafael =?iso-8859-1?q?=C1vila_de_Esp=EDndola?= 
	<rafael.espindola@gmail.com>
To: gentoo-catalyst@gentoo.org, linux-kernel@vger.kernel.org
Subject: Re: unmounting a filesystem mounted by /init (initramfs)
Date: Fri, 29 Jul 2005 17:24:33 -0300
User-Agent: KMail/1.8.1
References: <564d96fb050728154923ba8663@mail.gmail.com> <200507290834.35504.vda@ilport.com.ua>
In-Reply-To: <200507290834.35504.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart22472691.TcO0OJfLzY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507291724.39103.rafael.espindola@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart22472691.TcO0OJfLzY
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Use lazy umount (umount -l) while fs is still visible
This works after all :)

I was I bit confused on how to remove the ext2 from the union but manage to=
 do=20
it. Then it was a simple matter of implementing lazy unmount in busybox.

Thank you very much,
Rafael

--nextPart22472691.TcO0OJfLzY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC6pCHLlrfGJ8JUHwRApuXAJ90achLwm1NFc38uGxAPTUe+4bCrgCfbewA
salOLXQ+SXK02dYaaA/YVXg=
=eD9M
-----END PGP SIGNATURE-----

--nextPart22472691.TcO0OJfLzY--
