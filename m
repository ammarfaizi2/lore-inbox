Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUF0MzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUF0MzN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 08:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUF0MzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 08:55:13 -0400
Received: from mout0.freenet.de ([194.97.50.131]:61389 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S262389AbUF0MzH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 08:55:07 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
Date: Sun, 27 Jun 2004 14:54:16 +0200
User-Agent: KMail/1.6.2
References: <200406251840.46577.mbuesch@freenet.de> <40DEB6CC.4030208@kolivas.org> <40DEB7B1.5010102@kolivas.org>
In-Reply-To: <40DEB7B1.5010102@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406271454.32356.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 27 June 2004 14:04, you wrote:
> Con Kolivas wrote:
> > Here is an incremental patch from 2.6.7-staircase7.4 (without any later 
> > changes) to staircase7.6 which I hope addresses your problem of no 
> > timeslice tasks. Can you try it please? Sorry about the previous noise.
> > 
> > Con
> > 
> > P.S.
> > Those with ck kernels I'm about to post another diff for -ck addressing 
> > the same thing.
> 
> 
> Eeek that one I posted _was_ the one for ck kernels. This is the one for 
> vanilla kernels with staircase7.4. Crikey I'm having a blowout here.

No, sorry Con.
The problem did not go away.

I just verified, that it definately is no issue with -bk7. So
I patched a clean vanilla 2.6.7 to staircase-7.6.

I just double verified that the patch is applied and the correct
kernel is loaded.

> Con
> 

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3sOFFGK1OIvVOP4RAkR1AKC/b04v2I5Dt2aoDRdTCiSwDSx7RQCfYJo2
EA2yhCP0Jukv9VbeOjaUrvo=
=WAYD
-----END PGP SIGNATURE-----
