Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263239AbSJCJzA>; Thu, 3 Oct 2002 05:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263243AbSJCJzA>; Thu, 3 Oct 2002 05:55:00 -0400
Received: from gromit.trivadis.com ([193.73.126.130]:14227 "EHLO trivadis.com")
	by vger.kernel.org with ESMTP id <S263239AbSJCJzA>;
	Thu, 3 Oct 2002 05:55:00 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Thu, 3 Oct 2002 11:51:32 +0200
From: Tim Tassonis <timtas@dplanet.ch>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.50: aha152x does not compile
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17x2do-00033X-00@trivadis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


I downloaded 2.4.50 and tried to compile, but it fails in aha152x:


  gcc -Wp,-MD,./.aha152x.o.d -D__KERNEL__ -I/opt/src/linux-2.5.40/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -I/opt/src/linux-2.5.40/arch/i386/mach-generic -nostdinc
-iwithprefix include -DMODULE -include
/opt/src/linux-2.5.40/include/linux/modversions.h  -DAHA152X_STAT
-DAUTOCONF -DKBUILD_BASENAME=aha152x   -c -o aha152x.o aha152x.c
drivers/scsi/aha152x.c: In function `intr':
drivers/scsi/aha152x.c:1944: warning: implicit declaration of function
`queue_task'
drivers/scsi/aha152x.c:1944: `tq_immediate' undeclared (first use in this
function)
drivers/scsi/aha152x.c:1944: (Each undeclared identifier is reported only
once
drivers/scsi/aha152x.c:1944: for each function it appears in.)
drivers/scsi/aha152x.c:1945: warning: implicit declaration of function
`mark_bh'
drivers/scsi/aha152x.c:1945: `IMMEDIATE_BH' undeclared (first use in this
function)


This is with gcc 2.95.3

Bye
Tim
