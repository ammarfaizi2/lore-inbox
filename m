Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318435AbSGSELW>; Fri, 19 Jul 2002 00:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318439AbSGSELV>; Fri, 19 Jul 2002 00:11:21 -0400
Received: from avtodor.gorny.ru ([212.164.99.171]:17424 "EHLO mail.ruad")
	by vger.kernel.org with ESMTP id <S318435AbSGSELV>;
	Fri, 19 Jul 2002 00:11:21 -0400
Date: Fri, 19 Jul 2002 11:13:35 +0700
From: Sokolov Sergei <s_sokolov@avtodor.gorny.ru>
X-Mailer: The Bat! (v1.60c) Personal
Reply-To: Sokolov Sergei <s_sokolov@avtodor.gorny.ru>
X-Priority: 3 (Normal)
Message-ID: <1777861033.20020719111335@avtodor.gorny.ru>
To: linux-kernel@vger.kernel.org
Subject: Re[2]: linux-2.4.19-rc2aa1 (RH7.2 kgcc: Internal compiler error in function add_pending_init)
In-Reply-To: <20020719032653.96817.qmail@web9207.mail.yahoo.com>
References: <20020719032653.96817.qmail@web9207.mail.yahoo.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on mail/Gorno-Altaiavtodor(Release 5.0.9a |January 7, 2002) at
 19.07.2002 11:13:43,
	Serialize by Router on mail/Gorno-Altaiavtodor(Release 5.0.9a |January 7, 2002) at
 19.07.2002 11:13:51,
	Serialize complete at 19.07.2002 11:13:51
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alex,

Friday, July 19, 2002, 10:26:53 AM, you wrote:

AD> The only time this ever happened to me, it turned out one of my 
AD> RAM sticks had failed. Just out of curiosity, have you had any 
AD> oopses recently?

AD> Hi All !!
AD> When I try compile kernel on my RH7.2
AD> with CC=kgcc, I receive this message:

AD> kgcc  -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux-2.4.19-rc2aa1/include -traditional \
AD> -c head.S -o head.o kgcc  -D__KERNEL__ -I/usr/src/linux-2.4.19-rc2aa1/include -Wall \
AD> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-st rict-aliasing -fno-common \
AD> -fomit-frame-pointer -pipe  -march=i686   -nostdinc -I /usr/lib/gcc-lib/i386-redhat- \
AD> linux/egcs-2.91.66/include -DKBUILD_BASENAME=init_task  -c -o init_task.o init_task.c \
AD> ../../gcc/c-typeck.c:5945: Internal compiler error in function add_pending_init \
AD> make[1]: *** [init_task.o] Error 1 make[1]: Leaving directory \
AD>                 `/usr/src/linux-2.4.19-rc2aa1/arch/i386/kernel'
AD> make: *** [_dir_arch/i386/kernel] Error 2

AD> __________________________________________________
AD> Do You Yahoo!?
AD> Yahoo! Autos - Get free new car price quotes
AD> http://autos.yahoo.com
AD> -
AD> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
AD> the body of a message to majordomo@vger.kernel.org
AD> More majordomo info at  http://vger.kernel.org/majordomo-info.html
AD> Please read the FAQ at  http://www.tux.org/lkml/

With  kernel linux-2.4.19-rc2aa1 I not had any oops.
Uptime my linux box - one day.
But my kernel  linux-2.4.19-rc1 + xfs patch give me  message:
kernel BUG at buffer.c:549!  when I'm copying files between xfs
partitions. This kernel I had comiled with kgcc.
I have Promise FastTrak Tx4 controller with two mirror raid arrays, and
all partitions locates on this /dev/ataraid devices.







-- 
Best regards,
 Sergei Sokolov                            mailto:s_sokolov@avtodor.gorny.ru

