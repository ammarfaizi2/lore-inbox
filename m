Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWHPHDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWHPHDN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 03:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWHPHDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 03:03:13 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:15238 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750953AbWHPHDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 03:03:12 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Drop second arg of unregister_chrdev()
Date: Wed, 16 Aug 2006 09:03:19 +0200
User-Agent: KMail/1.9.4
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060815033522.GA5163@martell.zuzino.mipt.ru> <20060815195231.17015.qmail@lwn.net>
In-Reply-To: <20060815195231.17015.qmail@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3790214.FnJS5yQWdO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608160903.25145.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3790214.FnJS5yQWdO
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jonathan Corbet wrote:
> > * "name" is trivially unused.
> > * Requirement to pass to unregister function anything but cookie you've
> >   got from register counterpart is wrong.
>
> Might this, instead, be an opportunity to get rid of the internal
> register_chrdev() and unregister_chrdev() calls in favor of the cdev
> interface?  register_chrdev() is a bit of a backward-compatibility hack
> at this point, and cdevs, in theory, are safer since they won't present
> drivers with minor numbers they might not be prepared to handle.

In this case I would suggest to add documentation to this functions first t=
o=20
get people the chance to actually know how to use them.

Eike

--nextPart3790214.FnJS5yQWdO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBE4sM9XKSJPmm5/E4RAvgxAKCXIAQ07wINyZcCAtcQeMROVTsQ4ACfZYMu
5txYD1ftw0/5tDZnRpcJ4PM=
=pChZ
-----END PGP SIGNATURE-----

--nextPart3790214.FnJS5yQWdO--
