Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313367AbSC2GAf>; Fri, 29 Mar 2002 01:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313368AbSC2GA1>; Fri, 29 Mar 2002 01:00:27 -0500
Received: from domail03.so-net.ne.jp ([210.139.252.195]:13581 "HELO
	domail03.so-net.ne.jp") by vger.kernel.org with SMTP
	id <S313367AbSC2GAK>; Fri, 29 Mar 2002 01:00:10 -0500
Message-ID: <3CA402DB.8050408@BeansYou.co.jp>
Date: Fri, 29 Mar 2002 14:59:55 +0900
From: Dragon_at_Work <m_giggey@BeansYou.co.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us, zh, zh-cn, zh-tw, en-gb, 
MIME-Version: 1.0
To: Kernel ML <linux-kernel@vger.kernel.org>
Subject: strange problem with 'make modules_install' -2.4.17, 2.4.18
Content-Type: multipart/mixed;
 boundary="------------080502060201080005070609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080502060201080005070609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Using RH7.2 and trying to upgrade the Kernel.

other makes seem to work fine (mrproper, menuconfig, dep, clean, 
bzImage, modules).
But, when I 'make modules_install', it seems to prematurely abort the 
process.
The symptom is, in my idea, related to a defective makefile script. 
However, on my other machine, there is no such occurance (and it is 
RH7.2 (now) using 2.4.17).

attached is the text of invoking 'make modules_install'

Please advise on what I am doing wrong.

There seems to be nothing to address this problem in either the howtos, 
faqs, or WWW.

Thanks in advance.



--------------080502060201080005070609
Content-Type: text/plain;
 name="modules_install__output.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modules_install__output.txt"

make -C  kernel modules_install
make[1]: Entering directory `/usr/src/linux-2.4.18/kernel'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.4.18/kernel'
make -C  drivers modules_install
make[1]: Entering directory `/usr/src/linux-2.4.18/drivers'
make -C block modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/drivers/block'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.18/drivers/block'
make -C cdrom modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/drivers/cdrom'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.18/drivers/cdrom'
make -C char modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/drivers/char'
make -C drm modules_install
make[3]: Entering directory `/usr/src/linux-2.4.18/drivers/char/drm'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory `/usr/src/linux-2.4.18/drivers/char/drm'
make[2]: Leaving directory `/usr/src/linux-2.4.18/drivers/char'
make -C hotplug modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/drivers/hotplug'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.18/drivers/hotplug'
make -C ide modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/drivers/ide'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.18/drivers/ide'
make -C ieee1394 modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/drivers/ieee1394'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.18/drivers/ieee1394'
make -C media modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/drivers/media'
make -C radio modules_install
make[3]: Entering directory `/usr/src/linux-2.4.18/drivers/media/radio'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory `/usr/src/linux-2.4.18/drivers/media/radio'
make -C video modules_install
make[3]: Entering directory `/usr/src/linux-2.4.18/drivers/media/video'
mkdir -p /lib/modules/2.4.18/kernel/drivers/media/video/
cp c-qcam.o bw-qcam.o stradis.o cpia.o /lib/modules/2.4.18/kernel/drivers/media/video/
make[3]: Leaving directory `/usr/src/linux-2.4.18/drivers/media/video'
make[2]: Leaving directory `/usr/src/linux-2.4.18/drivers/media'
make -C misc modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/drivers/misc'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.18/drivers/misc'
make -C net modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/drivers/net'
mkdir -p /lib/modules/2.4.18/kernel/drivers/net/
cp dummy.o /lib/modules/2.4.18/kernel/drivers/net/
make[2]: Leaving directory `/usr/src/linux-2.4.18/drivers/net'
make -C parport modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/drivers/parport'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.18/drivers/parport'
make -C pnp modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/drivers/pnp'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.18/drivers/pnp'
make -C scsi modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/drivers/scsi'
mkdir -p /lib/modules/2.4.18/kernel/drivers/scsi/
cp sr_mod.o sg.o /lib/modules/2.4.18/kernel/drivers/scsi/
make[2]: Leaving directory `/usr/src/linux-2.4.18/drivers/scsi'
make -C sound modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/drivers/sound'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.18/drivers/sound'
make -C video modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/drivers/video'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.18/drivers/video'
make[1]: Leaving directory `/usr/src/linux-2.4.18/drivers'
make -C  mm modules_install
make[1]: Entering directory `/usr/src/linux-2.4.18/mm'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.4.18/mm'
make -C  fs modules_install
make[1]: Entering directory `/usr/src/linux-2.4.18/fs'
make -C nls modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/fs/nls'
mkdir -p /lib/modules/2.4.18/kernel/fs/nls/
cp nls_cp437.o nls_cp932.o nls_sjis.o nls_euc-jp.o nls_cp950.o nls_big5.o /lib/modules/2.4.18/kernel/fs/nls/
make[2]: Leaving directory `/usr/src/linux-2.4.18/fs/nls'
make -C ntfs modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/fs/ntfs'
mkdir -p /lib/modules/2.4.18/kernel/fs/ntfs/
cp ntfs.o /lib/modules/2.4.18/kernel/fs/ntfs/
make[2]: Leaving directory `/usr/src/linux-2.4.18/fs/ntfs'
make -C umsdos modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/fs/umsdos'
mkdir -p /lib/modules/2.4.18/kernel/fs/umsdos/
cp umsdos.o /lib/modules/2.4.18/kernel/fs/umsdos/
make[2]: Leaving directory `/usr/src/linux-2.4.18/fs/umsdos'
make[1]: Leaving directory `/usr/src/linux-2.4.18/fs'
make -C  net modules_install
make[1]: Entering directory `/usr/src/linux-2.4.18/net'
make -C ipv4 modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/net/ipv4'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.18/net/ipv4'
make -C netlink modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/net/netlink'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.18/net/netlink'
make -C sched modules_install
make[2]: Entering directory `/usr/src/linux-2.4.18/net/sched'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.18/net/sched'
make[1]: Leaving directory `/usr/src/linux-2.4.18/net'
make -C  ipc modules_install
make[1]: Entering directory `/usr/src/linux-2.4.18/ipc'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.4.18/ipc'
make -C  lib modules_install
make[1]: Entering directory `/usr/src/linux-2.4.18/lib'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.4.18/lib'
make -C  arch/i386/kernel modules_install
make[1]: Entering directory `/usr/src/linux-2.4.18/arch/i386/kernel'
mkdir -p /lib/modules/2.4.18/kernel/arch/i386/kernel/
cp cpuid.o /lib/modules/2.4.18/kernel/arch/i386/kernel/
make[1]: Leaving directory `/usr/src/linux-2.4.18/arch/i386/kernel'
make -C  arch/i386/mm modules_install
make[1]: Entering directory `/usr/src/linux-2.4.18/arch/i386/mm'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.4.18/arch/i386/mm'
make -C  arch/i386/lib modules_install
make[1]: Entering directory `/usr/src/linux-2.4.18/arch/i386/lib'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.4.18/arch/i386/lib'
cd /lib/modules/2.4.18; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.18; fi

--------------080502060201080005070609--

