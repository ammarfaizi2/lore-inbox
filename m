Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVEOHnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVEOHnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 03:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVEOHnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 03:43:09 -0400
Received: from h80ad2528.async.vt.edu ([128.173.37.40]:55556 "EHLO
	h80ad2528.async.vt.edu") by vger.kernel.org with ESMTP
	id S261544AbVEOHnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 03:43:04 -0400
Message-Id: <200505150742.j4F7gds1020180@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: Edgar Toernig <froese@gmx.de>, jmerkey <jmerkey@utah-nac.org>,
       Scott Robert Ladd <lkml@coyotegulch.com>, linux-kernel@vger.kernel.org
Subject: Re: Automatic .config generation 
In-Reply-To: Your message of "Sun, 15 May 2005 09:03:42 +0200."
             <200505150903.42212.petkov@uni-muenster.de> 
From: Valdis.Kletnieks@vt.edu
References: <42839AF7.4030708@coyotegulch.com> <42838D4C.3040207@utah-nac.org> <20050512231726.6198bbc6.froese@gmx.de>
            <200505150903.42212.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116142954_5152P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 15 May 2005 03:42:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116142954_5152P
Content-Type: text/plain; charset=us-ascii

On Sun, 15 May 2005 09:03:42 +0200, Borislav Petkov said:
> On Thursday 12 May 2005 23:17, Edgar Toernig wrote:
> > jmerkey wrote:
> > > Scott Robert Ladd wrote:
> > > >Is there a utility that creates a .config based on analysis of the
> > > >target system?

> how about /proc/config.gz.. although this was pretty recent IIRC.

That describes the currently running kernel *as built* - so for instance
booting a RedHat kernel on almost anything will show 3 zillion things
built as modules - including 2.5 zillion things that aren't needed in the
current config (for instance, every single sound card driver may be included).

What is desired is a utility that will do an lspci/lsusb/etc and build up
a .config that matches *the current hardware* (for instance, only including
a module for the one sound card that's actually installed).

--==_Exmh_1116142954_5152P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFChv1qcC3lWbTT17ARAsgmAJ9uPxOUuHr7GzrgLmmpS2wcK1+hfACfcycT
8PC+gsnbDk5RMphYgDQ7E9Y=
=f9Df
-----END PGP SIGNATURE-----

--==_Exmh_1116142954_5152P--
