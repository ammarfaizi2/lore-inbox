Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWC1Fho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWC1Fho (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 00:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWC1Fho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 00:37:44 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:49292 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751309AbWC1Fho (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 00:37:44 -0500
Message-Id: <200603280537.k2S5bLvZ012916@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Lee Revell <rlrevell@joe-job.com>
Cc: Greg Lee <glee@swspec.com>, linux-kernel@vger.kernel.org,
       rmk+kernel@arm.linux.org.uk
Subject: Re: HZ != 1000 causes problem with serial device shown by git-bisect 
In-Reply-To: Your message of "Mon, 27 Mar 2006 20:27:19 EST."
             <1143509240.1792.337.camel@mindpipe> 
From: Valdis.Kletnieks@vt.edu
References: <0e6601c651f8$9d253b40$a100a8c0@casabyte.com>
            <1143509240.1792.337.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1143524241_2772P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Mar 2006 00:37:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1143524241_2772P
Content-Type: text/plain; charset=us-ascii

On Mon, 27 Mar 2006 20:27:19 EST, Lee Revell said:
> On Mon, 2006-03-27 at 18:46 -0500, Greg Lee wrote:
> > I have also tried a number of other kernels and the problem exists all
> > the way to 2.6.15.6
> > but is fixed in 2.6.16, so I am going to git-bisect 2.6.15.6 to
> > 2.6.16, but I thought I
> > would get this message out now in case someone has an inkling of what
> > the problem is. 
> 
> If it's fixed in 2.6.16, what's the problem?  It's not as if we can go
> back and fix those old kernels...

I may be misreading Greg's concern, but I got the feeling that he's worried
that 2.6.16 isn't *really* fixed, but that something is just papering over the
driver's innate displeasure with HZ==250 (and thus it's likely that in .17 or
.18 or whenever, some *other* patch will make it re-manifest).

And we've seen *enough* bugs that only manifest in even or odd or
divisible-by-7.48 kernels that we know that "it works in 2.6.16" is vastly
different than being able to point at a changeset (or even a stream of fixes)
and say "fixed by that" or "probably went away when this stream of patches
totally reworked the code".


--==_Exmh_1143524241_2772P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEKMuRcC3lWbTT17ARAj09AJwKeItzDEQ75haCwVN2Iiy+OKGIlwCghjGs
uBytxezgvwIVIl8VEFq8LJM=
=He1M
-----END PGP SIGNATURE-----

--==_Exmh_1143524241_2772P--
