Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132169AbRA3Vpn>; Tue, 30 Jan 2001 16:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132374AbRA3Vpd>; Tue, 30 Jan 2001 16:45:33 -0500
Received: from chaos.analogic.com ([204.178.40.224]:14208 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132169AbRA3Vp2>; Tue, 30 Jan 2001 16:45:28 -0500
Date: Tue, 30 Jan 2001 16:45:16 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Version 2.4.1 cannot be built. 
Message-ID: <Pine.LNX.3.95.1010130164236.3322A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The subject says it all. `make dep` is now broken.

make[1]: Entering directory `/usr/src/linux-2.4.1/arch/i386/boot'
make[1]: Nothing to be done for `dep'.
make[1]: Leaving directory `/usr/src/linux-2.4.1/arch/i386/boot'
scripts/mkdep init/*.c > .depend
scripts/mkdep `find /usr/src/linux-2.4.1/include/asm /usr/src/linux-2.4.1/include/linux /usr/src/linux-2.4.1/include/scsi /usr/src/linux-2.4.1/include/net -name SCCS -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
make _sfdep_kernel _sfdep_drivers _sfdep_mm _sfdep_fs _sfdep_net _sfdep_ipc _sfdep_lib _sfdep_arch/i386/kernel _sfdep_arch/i386/mm _sfdep_arch/i386/lib _FASTDEP_ALL_SUB_DIRS="kernel drivers mm fs net ipc lib arch/i386/kernel arch/i386/mm arch/i386/lib"
make[1]: Entering directory `/usr/src/linux-2.4.1'
make -C kernel fastdep
make[2]: Entering directory `/usr/src/linux-2.4.1/kernel'
/usr/src/linux-2.4.1/scripts/mkdep acct.c capability.c context.c dma.c exec_domain.c exit.c fork.c info.c itimer.c kmod.c ksyms.c module.c panic.c pm.c printk.c ptrace.c resource.c sched.c signal.c softirq.c sys.c sysctl.c time.c timer.c uid16.c user.c > 
.depend
make[2]: Leaving directory `/usr/src/linux-2.4.1/kernel'
make -C drivers fastdep
make[2]: Entering directory `/usr/src/linux-2.4.1/drivers'
/usr/src/linux-2.4.1/scripts/mkdep  > .depend
make _sfdep_acpi _sfdep_atm _sfdep_block _sfdep_cdrom _sfdep_char _sfdep_dio _sfdep_fc4 _sfdep_i2c _sfdep_i2o _sfdep_ide _sfdep_ieee1394 _sfdep_input _sfdep_isdn _sfdep_macintosh _sfdep_md _sfdep_media _sfdep_misc _sfdep_mtd _sfdep_net _sfdep_net/hamradio
 _sfdep_nubus _sfdep_parport _sfdep_pci _sfdep_pcmcia _sfdep_pnp _sfdep_sbus _sfdep_scsi _sfdep_sgi _sfdep_sound _sfdep_tc _sfdep_telephony _sfdep_usb _sfdep_video _sfdep_zorro _FASTDEP_ALL_SUB_DIRS="acpi atm block cdrom char dio fc4 i2c i2o ide ieee1394 
input isdn macintosh md media misc mtd net net/hamradio nubus parport pci pcmcia pnp sbus scsi sgi sound tc telephony usb video zorro"
make[3]: Entering directory `/usr/src/linux-2.4.1/drivers'
make -C acpi fastdep
make[4]: Entering directory `/usr/src/linux-2.4.1/drivers/acpi'
Makefile:29: *** target pattern contains no `%'.  Stop.
make[4]: Leaving directory `/usr/src/linux-2.4.1/drivers/acpi'
make[3]: *** [_sfdep_acpi] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.1/drivers'
make[2]: *** [fastdep] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.1/drivers'
make[1]: *** [_sfdep_drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.1'
make: *** [dep-files] Error 2


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
