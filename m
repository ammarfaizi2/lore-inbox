Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290767AbSCSSo0>; Tue, 19 Mar 2002 13:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSCSSoK>; Tue, 19 Mar 2002 13:44:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57101 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290228AbSCSSnn>; Tue, 19 Mar 2002 13:43:43 -0500
Subject: Re: Linux 2.4.19pre3-ac2
To: bunk@fs.tum.de (Adrian Bunk)
Date: Tue, 19 Mar 2002 18:59:42 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.44.0203191938530.3932-100000@mimas.fachschaften.tu-muenchen.de> from "Adrian Bunk" at Mar 19, 2002 07:42:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nOpi-0008SY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> gcc -D__KERNEL__ -I/home/bunk/linux/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -DKBUILD_BASENAME=shm  -c -o shm.o shm.c
> shm.c: In function `sys_shmdt':
> shm.c:682: too few arguments to function `do_munmap'

Whoops - stick a ,1 on it
