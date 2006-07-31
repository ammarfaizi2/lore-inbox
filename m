Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWGaM7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWGaM7P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 08:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWGaM7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 08:59:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:18511 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750719AbWGaM7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 08:59:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=YiQev/zVqOkjMdXpAIBAVPV1lgNO2MbJXgRlopizon7fy2AujbinTxN9asYHrKYVH+cytrK7oT74nZEMdGAlGj/KcaLzrd7y7zG6nA26map934IBrdYgUvsE/y9Wxj2lEcwkevEjwDsm6TJobui/luVAgxWD42G16HmIUtT+VhU=
Date: Mon, 31 Jul 2006 08:59:13 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Preserving uptime with kexec?
Message-ID: <20060731125913.GA27083@phoenix>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Like many people, I like to brag about how great my uptime is.  But like
many other people, I like to keep my kernel up-to-date with the latest
and greatest from kernel.org.  I recently discovered the magic of kexec,
which allows me to switch kernels without rebooting for real.
Unfortunately, kexec resets my uptime when it runs.

Would anyone be interested in fixing this, and/or would anyone be
interested in *me* writing a patch for it?  I don't know if it violates
some contract where uptime is counted from the kernel boot, but it seems
like, for consistency's sake, it should count from the last hardware
boot.

--Thomas Tuttle

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEzf6h/UG6u69REsYRAv3IAJ426GTRIBXyE9RaaYX3AD3/Q58XPwCeIOVX
eOYNWQ2YgAwZnnWwqbgMREM=
=f6tL
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
