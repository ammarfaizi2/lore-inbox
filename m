Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVDDPNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVDDPNC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 11:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVDDPNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 11:13:01 -0400
Received: from hamlet.e18.physik.tu-muenchen.de ([129.187.154.223]:57277 "EHLO
	hamlet.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S261262AbVDDPM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 11:12:29 -0400
In-Reply-To: <1112625375.5680.45.camel@localhost.localdomain>
References: <1112577841.6035.40.camel@localhost.localdomain> <1112625375.5680.45.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-32--971130394"
Message-Id: <b49f28caf1982c57683ee7530afced25@e18.physik.tu-muenchen.de>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Subject: Re: UPDATE: out of vmalloc space - but vmalloc parameter does not allow boot
Date: Mon, 4 Apr 2005 17:12:19 +0200
To: Ranko Zivojnovic <ranko@spidernet.net>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-32--971130394
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Ranko!

On Apr 4, 2005, at 4:36 PM, Ranko Zivojnovic wrote:

> (please do CC replies as I am still not on the list)
>
> As I am kind of pressured to resolve this issue, I've set up a test
> environment using VMWare in order to reproduce the problem and
> (un)fortunately the attempt was successful.
>
> I have noticed a few points that relate to the size of the physical RAM
> and the behavior vmalloc. As I am not sure if this is by design or a
> bug, so please someone enlighten me:
>
> The strange thing I have seen is that with the increase of the physical
> RAM, the VmallocTotal in the /proc/meminfo gets smaller! Is this how it
> is supposed to be?
>
Well, I'm by no means a VM expert (not even a regular kernel hacker), 
but it seems to me that the sum of LowTotal and VmallocTotal is rather 
constant for the different settings. Alas, I cannot offer an 
explanation why this should be, so hopefully a knowledgeable person 
will shed some light on this issue.

Ciao,
					Roland

--
TU Muenchen, Physik-Department E18, James-Franck-Str. 85747 Garching
Telefon 089/289-12592; Telefax 089/289-12570
--
When I am working on a problem I never think about beauty.  I think
only how to solve the problem.  But when I have finished, if the
solution is not beautiful, I know it is wrong.
-- R. Buckminster Fuller
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GS/CS/M/MU d-(++) s:+ a-> C+++ UL++++ P-(+) L+++ E(+) W+ !N K- w--- M+ 
!V Y+
PGP++ t+(++) 5 R+ tv-- b+ DI++ e+++>++++ h---- x+++
------END GEEK CODE BLOCK------


--Apple-Mail-32--971130394
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFCUVlYI4MWO8QIRP0RAv7RAJ0RDqN3o4m3ueTXbZj2yGW4TxR1jgCffi62
Fa+GHKQBCb/K08CTvCsYCq0=
=U2cz
-----END PGP SIGNATURE-----

--Apple-Mail-32--971130394--

