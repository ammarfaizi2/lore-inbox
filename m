Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbUDAU1J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 15:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbUDAU1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 15:27:09 -0500
Received: from mout0.freenet.de ([194.97.50.131]:3549 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S263151AbUDAU06 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 15:26:58 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: root@chaos.analogic.com
Subject: Re: finding out the value of HZ from userspace
Date: Thu, 1 Apr 2004 23:27:08 +0200
User-Agent: KMail/1.6.2
References: <1079453698.2255.661.camel@cube> <20040401163047.GD25502@mail.shareable.org> <Pine.LNX.4.53.0404011146490.21282@chaos>
In-Reply-To: <Pine.LNX.4.53.0404011146490.21282@chaos>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200404012327.16950.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 01 April 2004 18:50, Richard B. Johnson wrote:
> I may be naive, but what's the matter with:
> 
> #include <stdio.h>
> #include <sys/param.h>   // Required to be here!
> int main()
> {
>     printf("HZ=%d\n", HZ);
>     return 0;
> }
> It works for me.

What when you compile this tool under a system with,
for example 2.4 kern-headers, and switch to a system
with a 2.6 kernel and kern-headers? It still reports
HZ=100 and that's not true anymore.

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAbIkzFGK1OIvVOP4RArmgAJ0QKFVPLjyYH/OZVox9TLGEGSKHWACcC6FP
b++fJyobg5K+FP7Nskx4Djo=
=SckD
-----END PGP SIGNATURE-----
