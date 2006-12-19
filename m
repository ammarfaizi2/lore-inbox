Return-Path: <linux-kernel-owner+w=401wt.eu-S932959AbWLSVtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932959AbWLSVtA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932960AbWLSVtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:49:00 -0500
Received: from quechua.inka.de ([193.197.184.2]:38059 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932959AbWLSVtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:49:00 -0500
X-Greylist: delayed 1537 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 16:49:00 EST
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19: OOPS in cat /proc/fs/nfs/exports
References: <E1GrJH9-0003Hr-00@bigred.inka.de> <17780.62607.544405.181452@cse.unsw.edu.au> <E1Gripc-0004KC-00@bigred.inka.de> <17783.28848.504885.606906@cse.unsw.edu.au> <E1GtWmU-0007Cu-00@bigred.inka.de> <17788.35808.421807.546159@cse.unsw.edu.au>
Organization: private Linux site, southern Germany
From: Olaf Titz <olaf@bigred.inka.de>
Date: Tue, 19 Dec 2006 22:23:05 +0100
Message-ID: <E1GwmQT-0005u9-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > I've replaced exportfs, mountd and nfsd with a newer version and it
> > works now.
>
> What version were you using?  I would really like to know.

The system in question was built on a Knoppix release based on Debian
Potato, with updates from Woody. Most likely this is the package
nfs-kernel-server 1.0-2woody3 based on nfs-utils 1.0, which is the oldest
version still to be found on the Debian mirrors.

(argh, I should have saved the old binaries and [more important, since
the binaries have no version indication] package docs...)

Olaf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFiFgxGPw4gdAdiZ0RAvXjAJ0X+BPu8cUg+IHEZRG51KWFKevFTwCfSGCr
j+fcUcfnunp1dyCDCrBlUBU=
=9Uqx
-----END PGP SIGNATURE-----
