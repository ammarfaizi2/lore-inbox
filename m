Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbSJDGkT>; Fri, 4 Oct 2002 02:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbSJDGkT>; Fri, 4 Oct 2002 02:40:19 -0400
Received: from [210.19.28.13] ([210.19.28.13]:38019 "HELO gateway.vault-id.com")
	by vger.kernel.org with SMTP id <S261505AbSJDGkS>;
	Fri, 4 Oct 2002 02:40:18 -0400
Message-ID: <35413.10.2.16.178.1033713943.squirrel@mail.Vault-ID.com>
Date: Fri, 4 Oct 2002 14:45:43 +0800 (MYT)
Subject: new compile error on 2.5.40-ac2 
From: "Corporal Pisang" <Corporal_Pisang@Counter-Strike.com.my>
To: <alan@redhat.com>
X-XheaderVersion: 1.1
X-UserAgent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20020923 Phoenix/0.1
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
Reply-To: Corporal_Pisang@Counter-Strike.com.my
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think I've never had this error on any of the 2.5.* series.

gcc -Wp,-MD,./.timer_pit.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -I/usr/src/linux/arch/i386/mach-generic -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=timer_pit   -c -o timer_pit.o
timer_pit.c
In file included from timer_pit.c:27:
/usr/src/linux/arch/i386/mach-generic/do_timer.h: In function
`do_timer_interrupt_hook':
/usr/src/linux/arch/i386/mach-generic/do_timer.h:26: `using_apic_timer'
undeclared (first use in this function)
/usr/src/linux/arch/i386/mach-generic/do_timer.h:26: (Each undeclared
identifier is reported only once
/usr/src/linux/arch/i386/mach-generic/do_timer.h:26: for each function it
appears in.)
/usr/src/linux/arch/i386/mach-generic/do_timer.h:27: warning: implicit
declaration of function `smp_local_timer_interrupt'
make[1]: *** [timer_pit.o] Error 1
make[1]: Leaving directory `/usr/src/linux/arch/i386/kernel'
make: *** [arch/i386/kernel] Error 2

Regards

-Ubaida-


