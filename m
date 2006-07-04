Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWGDPCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWGDPCK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWGDPCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:02:10 -0400
Received: from wx-out-0102.google.com ([66.249.82.199]:57519 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932183AbWGDPCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:02:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=b7GI8sIUXr5HgbQZIZPuxakbyIQUgukWfOz60mHrC0FDnAkz/I0BQzCqYD42S8e4ldATc2a0E4++mhYjRHO1R/wyVeOsGO0j5wzXf7lQHqePGujA4P74dVpmsbe8oCI8mxuF7U0ZX0D2WE+DsyLE0vcgVfVg40PRE/5sQRABGLU=
Date: Tue, 4 Jul 2006 11:02:05 -0400
From: Thomas Tuttle <thinkinginbinary+lkml@gmail.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Hdaps-devel] Generic interface for accelerometers (AMS, HDAPS, ...)
Message-ID: <20060704150205.GC3611@phoenix>
References: <20060703124823.GA18821@khazad-dum.debian.net> <20060704075950.GA13073@elf.ucw.cz> <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On July 04 at 06:26 EDT, Shem Multinymous hastily scribbled:
> Will moving the hdapsd userspace daemon from sysfs polling to the
> input infrastructure cause a noticable latency increase compared to
> polling sysfs? This functionality is highly time-critical.
>
> Also, there's a small issue with polling frequency. hdapsd needs a
> fairly high frequency (say, 50Hz) to gather statistics and keep
> response latency low, whereas the hdaps driver's internal polling
> (routing to the input infrastructure) is currently done at only 20Hz.
> We'll need to increase the latter, thereby slightly increasing system
> load when hdaps isn't running.

Just out of curiousity, is there any reason that these hard drive
parking schemes *aren't* implemented entirely in the kernel?  Wouldn't
implementing it in the kernel give it much lower latency?

--=20
Thomas Tuttle (thinkinginbinary@gmail.com)
Get Thunderbird: Reclaim your inbox. mozilla.org/products/thunderbird
aim/y!m:thinkinginbinary; icq:198113263; jabber:thinkinginbinary@jabber.org
msn: thinkinginbinary@hotmail.com; pgp: 0xAF5112C6

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEqoLt/UG6u69REsYRAmtyAJ9Vkj+DBKU40ruUpwgZ0kcWSWm6HQCePsAr
N+Pa7Sek1WiAEm3q/gSuUxQ=
=Z17I
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
