Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267488AbTACK4d>; Fri, 3 Jan 2003 05:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267490AbTACK4d>; Fri, 3 Jan 2003 05:56:33 -0500
Received: from pheniscidae.tvnetwork.hu ([80.95.85.58]:34312 "EHLO
	pheniscidae.TvNetWork.Hu") by vger.kernel.org with ESMTP
	id <S267488AbTACK4c>; Fri, 3 Jan 2003 05:56:32 -0500
Date: Fri, 3 Jan 2003 12:04:18 +0100
From: SZALAY Attila <sasa@pheniscidae.tvnetwork.hu>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.54
Message-ID: <20030103110418.GD7661@sasa.home>
References: <20030102103422.GB24116@sasa.home> <Pine.LNX.4.33L2.0301020745260.22868-100000@dragon.pdx.osdl.net> <20030103093250.GC7661@sasa.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030103093250.GC7661@sasa.home>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now I unset I2O completely to try compile new kernel.

But I have another problem.

make -f scripts/Makefile.build obj=drivers/scsi/pcmcia
  gcc -Wp,-MD,drivers/scsi/pcmcia/.aha152x_stub.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=aha152x_stub -DKBUILD_MODNAME=aha152x_cs   -c -o drivers/scsi/pcmcia/aha152x_stub.o drivers/scsi/pcmcia/aha152x_stub.c
make[4]: *** No rule to make target `drivers/scsi/pcmcia/aha152x.s', needed by `drivers/scsi/pcmcia/aha152x.o'.  Stop.

-- 
PGP ID 0x8D143771, /C5 95 43 F8 6F 19 E8 29  53 5E 96 61 05 63 42 D0
GPG ID   ABA0E8B2, 45CF B559 8281 8091 8469  CACD DB71 AEFC ABA0 E8B2

An exaggeration is a thruth that has lost its temper -- Kahlil Gibran
