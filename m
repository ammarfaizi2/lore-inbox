Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUEVMvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUEVMvN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 08:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUEVMvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 08:51:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10956 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261179AbUEVMvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 08:51:11 -0400
Date: Sat, 22 May 2004 14:51:09 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ioctl number 0xF3
Message-ID: <20040522125108.GB4589@devserv.devel.redhat.com>
References: <40AF42B3.8060107@winischhofer.net> <1085228451.14486.0.camel@laptop.fenrus.com> <40AF4A13.4020005@winischhofer.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <40AF4A13.4020005@winischhofer.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 22, 2004 at 02:39:47PM +0200, Thomas Winischhofer wrote:
> I intend using them for controlling SiS hardware specific settings like 
> switching output devices, checking modes against output devices, 
> repositioning TV output, scaling TV output, changing gamma correction, 
> tuning video parameters, and the like.

That doesn't in principle sound SiS specific. Sure the implementation will
be but the interface?

> And rest assured, they will be 32/64 bit safe. Not sure what you mean by 
> "ioctl interface" here but have a look at the Matrox framebuffer driver 
> which uses some 'n' ioctls for similar stuff (which in that way do not 
> apply to the SiS hardware which is why I can't reuse them).

Ok this is exactly the point I was trying to make. Would it be possible to
have the "new" ioctl interface be such that they CAN be used by both matrox
and Sis ?

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAr0y8xULwo51rQBIRAjCsAJ9H0R4+aGqv/tXIv09l9zaCLxXqPACfe/sY
I1NkWFq93otwuXJVHIvG3zo=
=54rU
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
