Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272387AbRIFD1Z>; Wed, 5 Sep 2001 23:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272393AbRIFD1P>; Wed, 5 Sep 2001 23:27:15 -0400
Received: from mx1.port.ru ([194.67.57.11]:43025 "EHLO smtp1.port.ru")
	by vger.kernel.org with ESMTP id <S272387AbRIFD1F>;
	Wed, 5 Sep 2001 23:27:05 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109060640.f866eJr09879@vegae.deep.net>
Subject: last fruits
To: linux-kernel@vger.kernel.org
Date: Thu, 6 Sep 2001 06:40:18 +0000 (UTC)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

      okay, the modules has compiled finally.
  here are the last error i seen. +1 bonus warning i spotted

=======WARNING=====================
gcc -D__KERNEL__ -I/usr/src/linux-stest/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include /usr/src/linux-stest/include/linux/modversions.h   -c -o pwc-ctrl.o pwc-ctrl.c
In file included from pwc-ctrl.c:28:
pwc.h:80: warning: `FRAME_SIZE' redefined
/usr/src/linux-stest/include/asm/ptrace.h:21: warning: this is the location of the previous definition

=======ERROR=======================
make[2]: *** No rule to make target `/etc/sound/dsp001.ld', needed by `pss_boot.h'.  Stop.
make[2]: Leaving directory `/usr/src/linux-stest/drivers/sound'
make[1]: *** [_modsubdir_sound] Error 2

=======ERROR=======================
vwsnd.c:148: linux/semaphore.h: No such file or directory
vwsnd.c: In function `attach_vwsnd':
vwsnd.c:3302: warning: implicit declaration of function `init_waitqueue'
vwsnd.c:3371: `MUTEX' undeclared (first use in this function)
vwsnd.c:3371: (Each undeclared identifier is reported only once
vwsnd.c:3371: for each function it appears in.)
vwsnd.c: At top level:
vwsnd.c:3447: warning: implicit declaration of function `CO_IRQ'
vwsnd.c:3447: `CO_APIC_LI_AUDIO' undeclared here (not in a function)
vwsnd.c:3448: initializer element is not constant
vwsnd.c:3448: (near initialization for `the_hw_config.irq')
make[2]: *** [vwsnd.o] Error 1
make[2]: Leaving directory `/usr/src/linux-stest/drivers/sound'
make[1]: *** [_modsubdir_sound] Error 2
make[1]: Leaving directory `/usr/src/linux-stest/drivers'
make: *** [_mod_drivers] Error 2

cheers,
 Sam
