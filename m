Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVDBMOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVDBMOw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 07:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVDBMOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 07:14:52 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:7144 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261385AbVDBMOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 07:14:49 -0500
From: Rolf Eike Beer <eike-hotplug@sf-tec.de>
To: Greg K-H <greg@kroah.com>
Subject: Re: [PATCH] PCI Hotplug: remove code duplication in drivers/pci/hotplug/ibmphp_pci.c
Date: Sat, 2 Apr 2005 14:20:11 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
References: <1112399271636@kroah.com>
In-Reply-To: <1112399271636@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6295064.cHhJHFD3Wb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504021420.16772@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6295064.cHhJHFD3Wb
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Greg KH wrote:
> ChangeSet 1.2181.16.9, 2005/03/17 13:54:33-08:00, eike-hotplug@sf-tec.de
>
> [PATCH] PCI Hotplug: remove code duplication in
> drivers/pci/hotplug/ibmphp_pci.c
>
> This patch removes some code duplication where if and else have the
> same code at the beginning and the end of the branch.

Greg, as you correctly pointed out this patch if broken. It could never rea=
ch=20
the if branch and always uses the else branch. Please drop this one and=20
review the patch I sent on March 21th to pcihp-discuss for inclusion. It=20
removes much more duplication and handles this case correctly. Sorry, it=20
looks like I forgot to CC you. I'll bounce this mail to you.

Eike

--nextPart6295064.cHhJHFD3Wb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBCTo4AXKSJPmm5/E4RAjAXAJ4y5XCD3hNZ0OKttbhrSDQgy5exUgCfT7Su
YaCO14VoE7ohBNDdU1YYIpc=
=qrUB
-----END PGP SIGNATURE-----

--nextPart6295064.cHhJHFD3Wb--
