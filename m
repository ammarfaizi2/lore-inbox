Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281787AbRL1QQg>; Fri, 28 Dec 2001 11:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281773AbRL1QQ0>; Fri, 28 Dec 2001 11:16:26 -0500
Received: from yinyang.hjsoft.com ([205.231.166.38]:20749 "EHLO
	yinyang.hjsoft.com") by vger.kernel.org with ESMTP
	id <S279768AbRL1QQN>; Fri, 28 Dec 2001 11:16:13 -0500
Date: Fri, 28 Dec 2001 11:24:43 -0500 (EST)
From: "Mr. Shannon Aldinger" <god@yinyang.hjsoft.com>
Reply-To: god@yinyang.hjsoft.com
To: Luigi Genoni <kernel@Expansa.sns.it>
cc: Nikita Danilov <Nikita@Namesys.COM>, <linux-kernel@vger.kernel.org>,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: reiserfs does not work with linux 2.4.17 on sparc64 CPUs
In-Reply-To: <Pine.LNX.4.33.0112281058130.30085-100000@Expansa.sns.it>
Message-ID: <Pine.LNX.4.40.0112281112520.28074-100000@yinyang.hjsoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 28 Dec 2001, Luigi Genoni wrote:

> OK, here is my oops
>
Well I think all of the endian-safe patches should be included with
2.4.17, you may also need to use reiserfsprogs-3.x.0k-pre10 or later as
they have endian patches too. My problem was not using the endian-safe
patches against the kernel and reiserfsprogs. However I didn't get an
oops.

Also note this (copied directly from the FAQ on www.namesys.com)
23. Can I use ReiserFS on other architectures than i386?
Yes, on DEC Alpha. You may be able to easily bribe us to do the port
though....

Kinda disappoint because it doesn't say where to get the endian-safe
patches, etc. To make it work on Sparc machines.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjwsnNwACgkQwtU6L/A4vVAOGQCfRXDHCMuDGpuJOz5s6OKUDMiY
cIMAni9Kpm6R5MOzeKHgU+EVrGPce4rU
=jyAs
-----END PGP SIGNATURE-----


