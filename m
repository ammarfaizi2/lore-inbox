Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267377AbUJGKBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267377AbUJGKBH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 06:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUJGKBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 06:01:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28583 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267377AbUJGJ72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:59:28 -0400
Subject: Re: Probable module bug in linux-2.6.5-1.358
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-o3n0JeOnAbmQznojbthU"
Organization: Red Hat UK
Message-Id: <1097143144.2789.19.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 07 Oct 2004 11:59:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-o3n0JeOnAbmQznojbthU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-10-07 at 00:08, Richard B. Johnson wrote:
> The attached script shows that an attempt to open a device
> after its module was removed, will seg-fault the kernel.

Oct  6 17:03:30 chaos kernel: Analogic Corp Datalink Driver : Module
removed

Oct  6 17:03:38 chaos kernel: EIP:    0060:[<021556ad>]    Not tainted
Oct  6 17:03:38 chaos kernel: EFLAGS: 00010206   (2.6.5-1.358-noreg)=20

since your module apparently is gpl (the kernel isn't tainted), can you
post a URL to the sourcecode so that we can point the bug out to you ?


--=-o3n0JeOnAbmQznojbthU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBZRNopv2rCoFn+CIRArVtAKCRJMDksD2B30lAcCToZMIiWotWcQCdFw+Z
cCpO23yBGXUkP8uKbdrkTEY=
=5HBP
-----END PGP SIGNATURE-----

--=-o3n0JeOnAbmQznojbthU--

