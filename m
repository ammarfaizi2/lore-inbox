Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269923AbRHEFzb>; Sun, 5 Aug 2001 01:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269924AbRHEFzW>; Sun, 5 Aug 2001 01:55:22 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:62980 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S269923AbRHEFzQ>; Sun, 5 Aug 2001 01:55:16 -0400
Message-Id: <200108050555.f755sx108234@jordan.goethel.local>
Content-Type: text/plain; charset=US-ASCII
From: Sven Goethel <sgoethel@jausoft.com>
Organization: Jausoft - Sven Goethel Software Development
To: Robert Kuebel <kuebelr@email.uc.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: system freezes w/ 2.4.7-pre4 and later
Date: Sun, 5 Aug 2001 07:54:57 +0200
X-Mailer: KMail [version 1.2.3]
In-Reply-To: <Pine.OSF.4.33.0108050048300.23006-100000@oz.uc.edu>
In-Reply-To: <Pine.OSF.4.33.0108050048300.23006-100000@oz.uc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 05 August 2001 07:28, Robert Kuebel wrote:
> My system has been hanging since I switched from 2.4.7-pre3.  The
> lock-up's seem to happen during periods of disk activity. I was usually
> able to reproduce the hangs by untar-ing the kernel source a few times.
> Also, these kernels tended to hang while fsck'ing.
>
> 2.4.7-pre3 was working fine, but 2.4.7-pre4 through 2.4.8-pre3 were not.
> Also 2.4.7-ac6 froze on me.
>

well, may be a bit OT .. but:

i had the freeze in conjunction with 
	- [2.4.7-pre4 .. 2.4.7] + xfs
	- iptables
	- pppoe

now, i use:
	- 2.4.7, xfs
	- 2.4.7-ac6 patch 
	  (only the netfilter part, cause the rest is not xfs clean ..)
	- iptables
	- pppoe
and it works nice !


> I am running on an Abit KT7 and an IBM-DTLA-307045 IDE drive.
>

hmm .. may be you did some hot hdparm settings ?

how about none hdparm settings ?

how about the 2.4.7ac6 patch ?
- -- 
mailto:sgoethel@jausoft.com
www   : http://www.jausoft.com ; pgp: http://www.jausoft.com/gpg/
voice : +49-521-2399440 ; fax : +49-521-2399442
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7bN+yHdOA30NoFAARAj2CAJ9tBeNiIn8OuGLRQ3UeMflcozZIrQCff34g
HgIFrt6RnEBiEw+vSt5mmWc=
=QD/7
-----END PGP SIGNATURE-----
