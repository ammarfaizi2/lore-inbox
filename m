Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290767AbSBQVkt>; Sun, 17 Feb 2002 16:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290807AbSBQVkk>; Sun, 17 Feb 2002 16:40:40 -0500
Received: from ulima.unil.ch ([130.223.144.143]:17536 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S290767AbSBQVkZ>;
	Sun, 17 Feb 2002 16:40:25 -0500
Date: Sun, 17 Feb 2002 22:40:18 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: ALSA problem...
Message-ID: <20020217214018.GA14895@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

make[3]: Entering directory `/usr/src/linux-2.5/sound/core'
ld -m elf_i386  -r -o snd.o sound.o init.o isadma.o memory.o info.o control.o misc.o device.o wrappers.o sound_oss.o info_oss.o
ld -m elf_i386  -r -o snd-timer.o timer.o
gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=rtctimer  -DEXPORT_SYMTAB -c rtctimer.c
rtctimer.c:75: parse error before `rtc_task'
rtctimer.c:75: warning: type defaults to `int' in declaration of `rtc_task'
rtctimer.c:75: warning: data definition has no type or storage class
rtctimer.c: In function `rtctimer_start':
rtctimer.c:99: `rtc_task_t' undeclared (first use in this function)
rtctimer.c:99: (Each undeclared identifier is reported only once
rtctimer.c:99: for each function it appears in.)
rtctimer.c:99: `rtc' undeclared (first use in this function)
rtctimer.c:99: invalid lvalue in assignment
rtctimer.c:101: warning: implicit declaration of function `rtc_control'
rtctimer.c: In function `rtctimer_stop':
rtctimer.c:110: `rtc_task_t' undeclared (first use in this function)
rtctimer.c:110: `rtc' undeclared (first use in this function)
rtctimer.c:110: invalid lvalue in assignment
rtctimer.c: In function `rtctimer_interrupt':
rtctimer.c:123: warning: implicit declaration of function `tasklet_hi_schedule'
rtctimer.c: In function `rtctimer_private_free':
rtctimer.c:143: `rtc_task_t' undeclared (first use in this function)
rtctimer.c:143: `rtc' undeclared (first use in this function)
rtctimer.c:143: invalid lvalue in assignment
rtctimer.c:145: warning: implicit declaration of function `rtc_unregister'
rtctimer.c: In function `rtctimer_init':
rtctimer.c:174: warning: implicit declaration of function `tasklet_init'
rtctimer.c:182: request for member `func' in something not a structure or union
rtctimer.c:183: request for member `private_data' in something not a structure or union
rtctimer.c:184: warning: implicit declaration of function `rtc_register'
rtctimer.c: At top level:
rtctimer.c:79: storage size of `rtc_tq' isn't known
make[3]: *** [rtctimer.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5/sound/core'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5/sound/core'
make[1]: *** [_subdir_core] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5/sound'
make: *** [_dir_sound] Error 2
36.060u 3.120s 0:40.23 97.3%    0+0k 0+0io 81103pf+0w
Exit 2

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
