Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSDTXWO>; Sat, 20 Apr 2002 19:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313309AbSDTXWN>; Sat, 20 Apr 2002 19:22:13 -0400
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:38920 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S313305AbSDTXWN>;
	Sat, 20 Apr 2002 19:22:13 -0400
Message-ID: <3CC1EC30.7020902@blueyonder.co.uk>
Date: Sat, 20 Apr 2002 22:31:12 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Organization: blueyonder
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre7-ac2 ACPI compile failure
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ar  rcs lib.a checksum.o old-checksum.o delay.o usercopy.o getuser.o 
memcpy.o strstr.o iodebug.o
make[2]: Leaving directory `/usr/src/linux/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
         --start-group \
         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o 
mm/mm.o fs/fs.o ipc/ipc.o \
          drivers/acpi/acpi.o drivers/parport/driver.o 
drivers/char/char.o drivers/block/block.o drivers/misc/misc.o 
drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o 
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/cdrom/driver.o 
drivers/sound/sounddrivers.o drivers/pci/driver.o 
drivers/pcmcia/pcmcia.o drivers/net/pcmcia/pcmcia_net.o 
drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o 
drivers/input/inputdrv.o drivers/message/i2o/i2o.o 
drivers/hotplug/vmlinux-obj.o \
         net/network.o \
         /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a 
/usr/src/linux/arch/i386/lib/lib.a \
         --end-group \
drivers/acpi/acpi.o: In function `sm_osl_proc_write_sleep':
drivers/acpi/acpi.o(.text+0x2bba1): undefined reference to 
`software_suspend'
make: *** [vmlinux] Error 1


Regards
-- 
Sid Boyce ... hamradio G3VBV ... Cessna/Warrior Pilot
Linux only shop


