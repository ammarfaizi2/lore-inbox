Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSGMRpE>; Sat, 13 Jul 2002 13:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSGMRpD>; Sat, 13 Jul 2002 13:45:03 -0400
Received: from lsanca2-ar27-4-3-064-252.lsanca2.dsl-verizon.net ([4.3.64.252]:7049
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S315265AbSGMRpD>; Sat, 13 Jul 2002 13:45:03 -0400
Date: Sat, 13 Jul 2002 10:47:40 -0700 (PDT)
From: Ben Clifford <benc@hawaga.org.uk>
To: Heinz Diehl <hd@cavy.de>
cc: linux-kernel@vger.kernel.org, <davej@codemonkey.org.uk>
Subject: Re: Linux 2.5.25-dj2
In-Reply-To: <20020713172627.GA5606@chiara.cavy.de>
Message-ID: <Pine.LNX.4.44.0207131046510.5808-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sat, 13 Jul 2002, Heinz Diehl wrote:

> From: Heinz Diehl <hd@cavy.de>

You beat me to it by a few minutes - I was just about to post that I am
experiencing the same error.

> 
>   gcc -Wp,-MD,./.ide-scsi24.o.d -D__KERNEL__ -I/usr/src/linux/include
>   -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
>   -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2
>   -march=k6 -nostdinc -iwithprefix include
>   -DKBUILD_BASENAME=ide_scsi24-c -o ide-scsi24.o ide-scsi24.c
>   ide-scsi24.c:847: unknown field abort' specified in initializer
>   ide-scsi24.c:847: warning: initialization from incompatible pointer type
>   ide-scsi24.c:848: unknown field reset' specified in initializer
>   ide-scsi24.c:848: warning: initialization from incompatible pointer type
>   make[3]: *** [ide-scsi24.o] Error 1
>   make[3]: Leaving directory /usr/src/linux/drivers/scsi'
>   make[2]: *** [scsi] Error 2
>   make[2]: Leaving directory /usr/src/linux/drivers'
>   make[1]: *** [drivers] Error 2
>   make[1]: Leaving directory /usr/src/linux'
>   make: *** [bzImage] Error 2
>   chiara:/usr/src/linux #
> 
> 

- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
http://www.hawaga.org.uk/ben/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9MGe/sYXoezDwaVARAqnfAJ0cnls/Xi0NovRg5Cef5T0gGHyL/ACeNe1b
VXmftNtyoMicwdlCow/FR58=
=7VdE
-----END PGP SIGNATURE-----

