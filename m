Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315513AbSGSB1e>; Thu, 18 Jul 2002 21:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315517AbSGSB1e>; Thu, 18 Jul 2002 21:27:34 -0400
Received: from avtodor.gorny.ru ([212.164.99.171]:60175 "EHLO mail.ruad")
	by vger.kernel.org with ESMTP id <S315513AbSGSB1e>;
	Thu, 18 Jul 2002 21:27:34 -0400
Date: Fri, 19 Jul 2002 08:26:41 +0700
From: Sokolov Sergei <s_sokolov@avtodor.gorny.ru>
X-Mailer: The Bat! (v1.60c) Personal
Reply-To: Sokolov Sergei <s_sokolov@avtodor.gorny.ru>
X-Priority: 3 (Normal)
Message-ID: <1722504971.20020719082641@avtodor.gorny.ru>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.19-rc2aa1 (RH7.2 kgcc: Internal compiler error in function add_pending_init)
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on mail/Gorno-Altaiavtodor(Release 5.0.9a |January 7, 2002) at
 19.07.2002 08:29:56,
	Serialize by Router on mail/Gorno-Altaiavtodor(Release 5.0.9a |January 7, 2002) at
 19.07.2002 08:30:04,
	Serialize complete at 19.07.2002 08:30:04
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All !!
When I try compile kernel on my RH7.2
with CC=kgcc, I receive this message:

kgcc  -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux-2.4.19-rc2aa1/include -traditional -c head.S -o head.o
kgcc  -D__KERNEL__ -I/usr/src/linux-2.4.19-rc2aa1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-st
rict-aliasing -fno-common -fomit-frame-pointer -pipe  -march=i686   -nostdinc -I /usr/lib/gcc-lib/i386-redhat-
linux/egcs-2.91.66/include -DKBUILD_BASENAME=init_task  -c -o init_task.o init_task.c
../../gcc/c-typeck.c:5945: Internal compiler error in function add_pending_init
make[1]: *** [init_task.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.19-rc2aa1/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2


-- 
Sergei Sokolov

