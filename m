Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318250AbSIEUdN>; Thu, 5 Sep 2002 16:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318255AbSIEUdN>; Thu, 5 Sep 2002 16:33:13 -0400
Received: from ulima.unil.ch ([130.223.144.143]:33154 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S318250AbSIEUdM>;
	Thu, 5 Sep 2002 16:33:12 -0400
Date: Thu, 5 Sep 2002 22:37:49 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre5-ac3 (p4-clockmod.c don't compil)
Message-ID: <20020905203749.GB3847@ulima.unil.ch>
References: <200209051544.g85Fi6i09215@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200209051544.g85Fi6i09215@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got:

gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix
include -DKBUILD_BASENAME=acpitable  -c -o acpitable.o acpitable.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix
include -DKBUILD_BASENAME=p4_clockmod  -c -o p4-clockmod.o p4-clockmod.c
p4-clockmod.c: In function `cpufreq_p4_validatedc':
p4-clockmod.c:84: `i' undeclared (first use in this function)
p4-clockmod.c:84: (Each undeclared identifier is reported only once
p4-clockmod.c:84: for each function it appears in.)
p4-clockmod.c: In function `cpufreq_p4_init':
p4-clockmod.c:146: warning: unused variable `l'
p4-clockmod.c:146: warning: unused variable `h'
make[1]: *** [p4-clockmod.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
