Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUIOLsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUIOLsv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 07:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUIOLsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 07:48:51 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:33443 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S265909AbUIOLsp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 07:48:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: offtopic: how to break huge patch into smaller independent patches?
Date: Wed, 15 Sep 2004 13:48:02 +0200
User-Agent: KMail/1.6.2
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       Anton Blanchard <anton@samba.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, paulus@samba.org
References: <41474B15.8040302@nortelnetworks.com> <4147C6D6.30508@nortelnetworks.com> <773640000.1095226032@[10.10.2.4]>
In-Reply-To: <773640000.1095226032@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_2vCSBq8gZHZ/WBR";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409151348.07346.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_2vCSBq8gZHZ/WBR
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mittwoch, 15. September 2004 07:27, Martin J. Bligh wrote:
> Personally I find source control tools utterly useless for exactly this=20
> reason. Akpm uses his own set of tools which someone packaged up as
> "quilt" I think. I have a similar set that works by patch number, his
> are controlled by a series file. Suggest you look at his tools - if he
> can manage a release every few days with several hundred patches in, they
> must work pretty well ;-)

Seconded. I just inherited an equally sized patch from another party
and started looking into quilt for this. It doesn't save you from
understanding the patch, but it works wonders reducing the overhead
of doing the split once you know what you want to end up with.

What I'm doing now is keeping the patch files from quilt in the
CVS tree that also contains the patched kernel itself.

	Arnd <><

--Boundary-02=_2vCSBq8gZHZ/WBR
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBSCv15t5GS2LDRf4RAuCpAKCDvysgEt8Y/0ZNnjORXR6qFpwe1QCfXQbf
AmJIbkrCrDwfZoUVPpv7AXM=
=U7Ir
-----END PGP SIGNATURE-----

--Boundary-02=_2vCSBq8gZHZ/WBR--
