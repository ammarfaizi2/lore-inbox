Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbSLLRWM>; Thu, 12 Dec 2002 12:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbSLLRWM>; Thu, 12 Dec 2002 12:22:12 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:56484 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264844AbSLLRWL> convert rfc822-to-8bit; Thu, 12 Dec 2002 12:22:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Schaufler <andreas.schaufler@gmx.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: NFS mounted rootfs possible via PCMCIA NIC ?
Date: Thu, 12 Dec 2002 18:29:41 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200212112253.57325.andreas.schaufler@gmx.de> <3DF7BD7F.85C6FEA0@digeo.com>
In-Reply-To: <3DF7BD7F.85C6FEA0@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212121829.42237.andreas.schaufler@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> > Hello list,
> >
> > I am trying to configure a notebook with a PCMCIA NIC to boot over
> > network. (kernel 2.4.20)
>
> Nope.  The kernel does the NFS thing before bringing up cardbus.
>
> This patch worked, back in the 2.4.17 days.  It also fixes some
> cardbus bugs.  I don't immediately recall what they were.


I got the 2.4.17 sources and applied the patch. yenta.c and main.c could not 
be patched automatically, so I tried to apply it by hand line by line.
Unfortunately when I boot a kernel compiled witch this modified sources I get 
an "Unable to handle kernel pagin request at virtual address 0000413d"

Maybe this patch is to be used on some Pre Version of 2.4.17 ?!?!

regards
- -Andreas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9+MeFhFLSFNIrGmsRAg0HAJ0RBZ/WKDxvv8YXXTLbT7REnqoVowCcC8tL
sGgZre0DIZOAdFVW6kn56rg=
=23D5
-----END PGP SIGNATURE-----

