Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbVIVN4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbVIVN4d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbVIVN4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:56:33 -0400
Received: from poseidon.ceid.upatras.gr ([150.140.141.169]:57179 "EHLO
	poseidon.ceid.upatras.gr") by vger.kernel.org with ESMTP
	id S1030348AbVIVN4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:56:31 -0400
Date: Thu, 22 Sep 2005 16:56:24 +0300
From: Nikos Ntarmos <ntarmos@ceid.upatras.gr>
To: Horms <horms@debian.org>
Cc: 329354@bugs.debian.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Frederik Schueler <fs@lowpingbastards.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CAN-2005-0204 and 2.4
Message-ID: <20050922135624.GA4346@diogenis.ceid.upatras.gr>
References: <E1EI1tH-0006Yy-00@master.debian.org> <20050922023025.GA20981@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <20050922023025.GA20981@verge.net.au>
Organization: NetCInS Lab., C.E.I.D., U. of Patras, Greece
WWW-Homepage: http://noth.ceid.upatras.gr/
X-PGP-Fingerprint: 9680 60A7 DE60 0298 B1F0  9B22 9BA2 7569 CF95 160A
Office-Phone: +30-2610-996919
Office-Fax: +30-2610-969011
GPS-Info: 38.2594N, 21.7428E
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi there.

On Thu, Sep 22, 2005 at 11:30:25AM +0900, Horms wrote:
> The problem that you see is a patch that was included in 2.4.27-11
> (the current version in sid), though it isn't built for amd64.
> 
> Could you see if the following patch works for you.

Yes it does. That's exactly what I also did to make it build, but I
didn't send in a patch as I wasn't sure that 4 (sizeof(u32)) is the
right factor for a 64-bit arch.

> I've CCed lkml and Marcelo for their consideration.  It seems to me
> that 2.4 is indeed vulnerable to CAN-2005-0204, perhaps someone can
> shed some light on this.

My intuition agrees with yours. However, as also stated in #329355 by
fs, "the amd64 port does not support 2.4 kernels, and there are no plans
to change this", so I guess this is not-a-bug for debian/x86_64.

\n\n
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Nikos "Nikolai" Ntarmos <ntarmos@ceid.upatras.gr>

iD8DBQFDMrgIm6J1ac+VFgoRAhbeAKCF2R6VkcHCsTYalKNnuvZeILlfMwCeMQDu
0C9BehFcgeBdor2abF+2wmo=
=Ihfo
-----END PGP SIGNATURE-----
