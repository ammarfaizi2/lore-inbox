Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbUBXP4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 10:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbUBXPyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 10:54:08 -0500
Received: from [212.239.224.65] ([212.239.224.65]:42112 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S262289AbUBXPux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 10:50:53 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Why are 2.6 modules so huge?
Date: Tue, 24 Feb 2004 16:50:46 +0100
User-Agent: KMail/1.6.1
References: <9cfptc4lckg.fsf@rogue.ncsl.nist.gov>
In-Reply-To: <9cfptc4lckg.fsf@rogue.ncsl.nist.gov>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402241650.49744.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 24 February 2004 16:30, Ian Soboroff wrote:
> Can anyone help me understand why 2.6-series kernel modules are so
> huge?
>
> $ cd /lib/modules
> $ ls -l */kernel/fs/vfat
> 2.4.20-18.8bigmem/kernel/fs/vfat:
> total 20
> -rw-r--r--    1 root     root        17678 May 29  2003 vfat.o
>
> 2.6.3/kernel/fs/vfat:
> total 288
> -rw-r--r--    1 root     root       289086 Feb 24 10:09 vfat.ko

You probably have some sort of debugging on.

devilkin@precious:/lib/modules/2.6.2/kernel/fs/vfat$ ls -l
total 20
- -rw-r--r--    1 root     root        18750 2004-02-09 12:56 vfat.ko

Jan
- --
I will make you shorter by the head.
		-- Elizabeth I
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAO3LYUQQOfidJUwQRAnSrAJ4oV2H2wxWBSL7OcEW4A0c13nq/ewCfbcgQ
LCE637rjKmxxbDpiAvVy1NE=
=UVX/
-----END PGP SIGNATURE-----
