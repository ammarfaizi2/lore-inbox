Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289854AbSBOPVD>; Fri, 15 Feb 2002 10:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289855AbSBOPUy>; Fri, 15 Feb 2002 10:20:54 -0500
Received: from sphere.open-net.org ([64.53.98.77]:45240 "EHLO pbx.open-net.org")
	by vger.kernel.org with ESMTP id <S289854AbSBOPUo>;
	Fri, 15 Feb 2002 10:20:44 -0500
Date: Fri, 15 Feb 2002 10:20:37 -0500
From: Robert Jameson <rj@open-net.org>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: oops with 2.4.18-pre9-mjc2
Message-Id: <20020215102037.00cf2ad9.rj@open-net.org>
In-Reply-To: <1013780277.950.663.camel@phantasy>
In-Reply-To: <20020215035135.0c26b130.rj@open-net.org>
	<1013780277.950.663.camel@phantasy>
X-Mailer: Sylpheed version 0.7.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.bX8?cv2o8WbpbN"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.bX8?cv2o8WbpbN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

It's appears right after my PDA finishes syncing, so im guessing, its
during a device close. To answer alans question im using nVidias kernel
driver, therefor i tainted the kernel (tm) (c).

On 15 Feb 2002 08:37:52 -0500
Robert Love <rml@tech9.net> wrote:

> On Fri, 2002-02-15 at 03:51, Robert Jameson wrote:
> > I have been seeing this oops from 2.4.16 -> 2.4.18-pre9, so here we
> > go!
> 
> Do you see this on device close?  It looks like there may be a race
> between device closer -> usb release.
> 
> Can you reproduce it without the binary module you are loading?
> 
> 	Robert Love


-- 
Robert Jameson                  http://rj.open-net.org
C2 Village at Wexford Hwy 278,  Tel: +1 (843) 757 9428
Hilton Head Isl, SC             Cel: +1 (843) 298 0957 
US, 29928.                      mailto:rj@open-net.org


--=.bX8?cv2o8WbpbN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8bSdJyWZRCCLwK/cRAq8VAJ971/wkwxM6++dvqX9xu1AGUBAatACdF3TS
sevwlSYfkgRWlNRtYtxBOvI=
=oKOi
-----END PGP SIGNATURE-----

--=.bX8?cv2o8WbpbN--

