Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbRHKKFR>; Sat, 11 Aug 2001 06:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266921AbRHKKE5>; Sat, 11 Aug 2001 06:04:57 -0400
Received: from mx7.port.ru ([194.67.57.17]:52879 "EHLO mx7.port.ru")
	by vger.kernel.org with ESMTP id <S266888AbRHKKEy>;
	Sat, 11 Aug 2001 06:04:54 -0400
Date: Sat, 11 Aug 2001 14:07:18 +0400
From: Nick Kurshev <nickols_k@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Can't compile linux-2.4.8
Message-Id: <20010811140718.18635ffb.nickols_k@mail.ru>
X-Mailer: Sylpheed version 0.5.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've just download patch-2.4.8.bz2 from ftp.kernel.org
and get following error message during compilation:

main.o(.modinfo+0x40): multiple definition of `__module_author'
joystick.o(.modinfo+0x80): first defined here
ld: Warning: size of symbol `__module_author' changed from 67 to 81 in main.o
main.o(.modinfo+0xa0): multiple definition of `__module_description'
joystick.o(.modinfo+0xe0): first defined here
ld: Warning: size of symbol `__module_description' changed from 83 to 96 in main.o
main.o: In function `init_module':
main.o(.text+0x1878): multiple definition of `init_module'
joystick.o(.text+0x240): first defined here
ld: Warning: size of symbol `init_module' changed from 64 to 67 in main.o
main.o: In function `cleanup_module':
main.o(.text+0x18bc): multiple definition of `cleanup_module'
joystick.o(.text+0x280): first defined here
make[3]: *** [emu10k1.o] Error 1
make[2]: *** [_modsubdir_emu10k1] Error 2
make[1]: *** [_modsubdir_sound] Error 2
make: *** [_mod_drivers] Error 2

My system is:

Linux  2.4.7 #2 Wed Jul 25 21:38:42 MSD 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79
binutils               2.11
util-linux             2.11f
mount                  2.11f
modutils               2.4.6
e2fsprogs              1.19
PPP                    2.4.1
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.53
Console-tools          0.2.2
Sh-utils               2.0
Modules Loaded         bsd_comp ppp_async ppp_generic slhc serial isa-pnp hpfs ide-cd cdrom isofs ide-floppy nls_koi8-r nls_cp437 vfat fat radio-sf16fmi videodev emu10k1 soundcore rtc unix

Any suggestions!

Best regards! Nick
