Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318336AbSGYDgQ>; Wed, 24 Jul 2002 23:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318338AbSGYDgQ>; Wed, 24 Jul 2002 23:36:16 -0400
Received: from [210.19.28.11] ([210.19.28.11]:61313 "EHLO
	dZuRa.int.Vault-ID.com") by vger.kernel.org with ESMTP
	id <S318336AbSGYDgP> convert rfc822-to-8bit; Wed, 24 Jul 2002 23:36:15 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Corporal Pisang <corporal_pisang@counter-strike.com.my>
Organization: Counter-Strike.com.my
To: linux-kernel@vger.kernel.org
Subject: 2.5.28 compile error: drivers/built-in.o: In function `analog_calibrate_timer':
Date: Thu, 25 Jul 2002 11:45:49 +0800
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207251145.49350.corporal_pisang@counter-strike.com.my>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


make[1]: Leaving directory `/usr/src/linux/init'
  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o 
arch/i386/kernel/init_task.o init/init.o --start-group 
arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o 
ipc/ipc.o security/built-in.o /usr/src/linux/arch/i386/lib/lib.a lib/lib.a 
/usr/src/linux/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o 
arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
drivers/built-in.o: In function `analog_calibrate_timer':
/usr/src/linux/drivers/input/joystick/analog.c:371: undefined reference to 
`save_flags'
/usr/src/linux/drivers/input/joystick/analog.c:372: undefined reference to 
`cli'
/usr/src/linux/drivers/input/joystick/analog.c:380: undefined reference to 
`restore_flags'
/usr/src/linux/drivers/input/joystick/analog.c:387: undefined reference to 
`save_flags'
/usr/src/linux/drivers/input/joystick/analog.c:388: undefined reference to 
`cli'
/usr/src/linux/drivers/input/joystick/analog.c:392: undefined reference to 
`restore_flags'
drivers/built-in.o: In function `gameport_measure_speed':
/usr/src/linux/drivers/input/gameport/gameport.c:97: undefined reference to 
`save_flags'
/usr/src/linux/drivers/input/gameport/gameport.c:98: undefined reference to 
`cli'
/usr/src/linux/drivers/input/gameport/gameport.c:103: undefined reference to 
`restore_flags'
make: *** [vmlinux] Error 1


Regards,

-- 
-----------------------
-Ubaida-

 
