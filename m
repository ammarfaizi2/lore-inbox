Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130515AbQLVLTt>; Fri, 22 Dec 2000 06:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131326AbQLVLTj>; Fri, 22 Dec 2000 06:19:39 -0500
Received: from cr957697-a.poco1.bc.wave.home.com ([24.112.113.125]:22020 "EHLO
	cr957697-a.poco1.bc.wave.home.com") by vger.kernel.org with ESMTP
	id <S130515AbQLVLT2>; Fri, 22 Dec 2000 06:19:28 -0500
Message-ID: <3A433194.956E889E@spamcop.net>
Date: Fri, 22 Dec 2000 02:48:52 -0800
From: "Bill K." <billy@spamcop.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops report.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[root@cr957697-a ksymoops]# ./ksymoops < the_oops.txt
WARNING: This version of ksymoops is obsolete.
WARNING: The current version can be obtained from ftp://ftp.ocs.com.au/pub/ksymoops
Options used: -V (default)
              -o /lib/modules/2.2.16-22/ (default)
              -k /proc/ksyms (default)
              -l /proc/modules (default)
              -m /usr/src/linux/System.map (default)
              -c 1 (default)

You did not tell me where to find symbol information.  I will assume
that the log matches the kernel and modules that are running right now
and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

/usr/bin/find: /lib/modules/2.2.16-22/build/pcmcia-cs-3.1.19/include/linux/compile.h: No such file or directory
/usr/bin/find: /lib/modules/2.2.16-22/build/pcmcia-cs-3.1.19/include/linux/config.h: No such file or directory
/usr/bin/find: /lib/modules/2.2.16-22/build/pcmcia-cs-3.1.19/include/linux/version.h: No such file or directory
/usr/bin/find: /lib/modules/2.2.16-22/build/pcmcia-cs-3.1.19/include/static/linux/compile.h: No such file or directory
/usr/bin/find: /lib/modules/2.2.16-22/build/pcmcia-cs-3.1.19/include/static/linux/config.h: No such file or directory
/usr/bin/find: /lib/modules/2.2.16-22/build/pcmcia-cs-3.1.19/include/static/linux/version.h: No such file or directory
./ksymoops: find_objects pclose failed 0x100
./ksymoops: read_system_map stat /usr/src/linux/System.map failed : No such file or directory
Error in compare_ksyms_lsmod, module parport_probe is in ksyms but not in lsmod
Error in compare_ksyms_lsmod, module parport_pc is in ksyms but not in lsmod
Error in compare_ksyms_lsmod, module lp is in ksyms but not in lsmod
Error in compare_ksyms_lsmod, module parport is in ksyms but not in lsmod
Warning: ide-cd symbol __insmod_ide-cd_O/lib/modules/2.2.16-22/block/ide-cd.o_M39A2E18B_V131600 not found in /lib/modules/2.2.16-22/block/ide-cd.o.  Ignoring
/lib/modules/2.2.16-22/block/ide-cd.o entry
Warning: ide-cd symbol __insmod_ide-cd_S.data_L172 not found in /lib/modules/2.2.16-22/block/ide-cd.o.  Ignoring /lib/modules/2.2.16-22/block/ide-cd.o entry
Warning: ide-cd symbol __insmod_ide-cd_S.rodata_L10416 not found in /lib/modules/2.2.16-22/block/ide-cd.o.  Ignoring /lib/modules/2.2.16-22/block/ide-cd.o entry
Warning: ide-cd symbol __insmod_ide-cd_S.text_L12527 not found in /lib/modules/2.2.16-22/block/ide-cd.o.  Ignoring /lib/modules/2.2.16-22/block/ide-cd.o entry
Warning: parport_probe symbol __insmod_parport_probe_O/lib/modules/2.2.16-22/misc/parport_probe.o_M39A2E18C_V131600 not found in
/lib/modules/2.2.16-22/misc/parport_probe.o.  Ignoring /lib/modules/2.2.16-22/misc/parport_probe.o entry
Warning: parport_probe symbol __insmod_parport_probe_S.data_L112 not found in /lib/modules/2.2.16-22/misc/parport_probe.o.  Ignoring
/lib/modules/2.2.16-22/misc/parport_probe.o entry
Warning: parport_probe symbol __insmod_parport_probe_S.rodata_L743 not found in /lib/modules/2.2.16-22/misc/parport_probe.o.  Ignoring
/lib/modules/2.2.16-22/misc/parport_probe.o entry
Warning: parport_probe symbol __insmod_parport_probe_S.text_L2171 not found in /lib/modules/2.2.16-22/misc/parport_probe.o.  Ignoring
/lib/modules/2.2.16-22/misc/parport_probe.o entry
Warning: parport_pc symbol __insmod_parport_pc_O/lib/modules/2.2.16-22/misc/parport_pc.o_M39A2E18C_V131600 not found in /lib/modules/2.2.16-22/misc/parport_pc.o.  Ignoring
/lib/modules/2.2.16-22/misc/parport_pc.o entry
Warning: parport_pc symbol __insmod_parport_pc_S.data_L352 not found in /lib/modules/2.2.16-22/misc/parport_pc.o.  Ignoring /lib/modules/2.2.16-22/misc/parport_pc.o entry
Warning: parport_pc symbol __insmod_parport_pc_S.rodata_L1573 not found in /lib/modules/2.2.16-22/misc/parport_pc.o.  Ignoring /lib/modules/2.2.16-22/misc/parport_pc.o
entry
Warning: parport_pc symbol __insmod_parport_pc_S.text_L4062 not found in /lib/modules/2.2.16-22/misc/parport_pc.o.  Ignoring /lib/modules/2.2.16-22/misc/parport_pc.o entry
Warning: lp symbol __insmod_lp_O/lib/modules/2.2.16-22/misc/lp.o_M39A2E18C_V131600 not found in /lib/modules/2.2.16-22/misc/lp.o.  Ignoring /lib/modules/2.2.16-22/misc/lp.o
entry
Warning: lp symbol __insmod_lp_S.data_L216 not found in /lib/modules/2.2.16-22/misc/lp.o.  Ignoring /lib/modules/2.2.16-22/misc/lp.o entry
Warning: lp symbol __insmod_lp_S.rodata_L480 not found in /lib/modules/2.2.16-22/misc/lp.o.  Ignoring /lib/modules/2.2.16-22/misc/lp.o entry
Warning: lp symbol __insmod_lp_S.text_L4324 not found in /lib/modules/2.2.16-22/misc/lp.o.  Ignoring /lib/modules/2.2.16-22/misc/lp.o entry
Warning: parport symbol __insmod_parport_O/lib/modules/2.2.16-22/misc/parport.o_M39A2E18C_V131600 not found in /lib/modules/2.2.16-22/misc/parport.o.  Ignoring
/lib/modules/2.2.16-22/misc/parport.o entry
Warning: parport symbol __insmod_parport_S.data_L16 not found in /lib/modules/2.2.16-22/misc/parport.o.  Ignoring /lib/modules/2.2.16-22/misc/parport.o entry
Warning: parport symbol __insmod_parport_S.rodata_L1594 not found in /lib/modules/2.2.16-22/misc/parport.o.  Ignoring /lib/modules/2.2.16-22/misc/parport.o entry
Warning: parport symbol __insmod_parport_S.text_L4706 not found in /lib/modules/2.2.16-22/misc/parport.o.  Ignoring /lib/modules/2.2.16-22/misc/parport.o entry
Warning: autofs symbol __insmod_autofs_O/lib/modules/2.2.16-22/fs/autofs.o_M39A2E18B_V131600 not found in /lib/modules/2.2.16-22/fs/autofs.o.  Ignoring
/lib/modules/2.2.16-22/fs/autofs.o entry
Warning: autofs symbol __insmod_autofs_S.data_L500 not found in /lib/modules/2.2.16-22/fs/autofs.o.  Ignoring /lib/modules/2.2.16-22/fs/autofs.o entry
Warning: autofs symbol __insmod_autofs_S.rodata_L828 not found in /lib/modules/2.2.16-22/fs/autofs.o.  Ignoring /lib/modules/2.2.16-22/fs/autofs.o entry
Warning: autofs symbol __insmod_autofs_S.text_L6989 not found in /lib/modules/2.2.16-22/fs/autofs.o.  Ignoring /lib/modules/2.2.16-22/fs/autofs.o entry
Warning: lockd symbol __insmod_lockd_O/lib/modules/2.2.16-22/fs/lockd.o_M39A2E18B_V131600 not found in /lib/modules/2.2.16-22/fs/lockd.o.  Ignoring
/lib/modules/2.2.16-22/fs/lockd.o entry
Warning: lockd symbol __insmod_lockd_S.bss_L444 not found in /lib/modules/2.2.16-22/fs/lockd.o.  Ignoring /lib/modules/2.2.16-22/fs/lockd.o entry
Warning: lockd symbol __insmod_lockd_S.data_L1712 not found in /lib/modules/2.2.16-22/fs/lockd.o.  Ignoring /lib/modules/2.2.16-22/fs/lockd.o entry
Warning: lockd symbol __insmod_lockd_S.rodata_L8389 not found in /lib/modules/2.2.16-22/fs/lockd.o.  Ignoring /lib/modules/2.2.16-22/fs/lockd.o entry
Warning: lockd symbol __insmod_lockd_S.text_L19659 not found in /lib/modules/2.2.16-22/fs/lockd.o.  Ignoring /lib/modules/2.2.16-22/fs/lockd.o entry
Warning: sunrpc symbol __insmod_sunrpc_O/lib/modules/2.2.16-22/misc/sunrpc.o_M39A2E18C_V131600 not found in /lib/modules/2.2.16-22/misc/sunrpc.o.  Ignoring
/lib/modules/2.2.16-22/misc/sunrpc.o entry
Warning: sunrpc symbol __insmod_sunrpc_S.bss_L4260 not found in /lib/modules/2.2.16-22/misc/sunrpc.o.  Ignoring /lib/modules/2.2.16-22/misc/sunrpc.o entry
Warning: sunrpc symbol __insmod_sunrpc_S.data_L780 not found in /lib/modules/2.2.16-22/misc/sunrpc.o.  Ignoring /lib/modules/2.2.16-22/misc/sunrpc.o entry
Warning: sunrpc symbol __insmod_sunrpc_S.rodata_L13922 not found in /lib/modules/2.2.16-22/misc/sunrpc.o.  Ignoring /lib/modules/2.2.16-22/misc/sunrpc.o entry
Warning: sunrpc symbol __insmod_sunrpc_S.text_L31347 not found in /lib/modules/2.2.16-22/misc/sunrpc.o.  Ignoring /lib/modules/2.2.16-22/misc/sunrpc.o entry
Warning: old_tulip symbol __insmod_old_tulip_O/lib/modules/2.2.16-22/net/old_tulip.o_M39A2E18B_V131600 not found in /lib/modules/2.2.16-22/net/old_tulip.o.  Ignoring
/lib/modules/2.2.16-22/net/old_tulip.o entry
Warning: old_tulip symbol __insmod_old_tulip_S.data_L980 not found in /lib/modules/2.2.16-22/net/old_tulip.o.  Ignoring /lib/modules/2.2.16-22/net/old_tulip.o entry
Warning: old_tulip symbol __insmod_old_tulip_S.rodata_L6690 not found in /lib/modules/2.2.16-22/net/old_tulip.o.  Ignoring /lib/modules/2.2.16-22/net/old_tulip.o entry
Warning: old_tulip symbol __insmod_old_tulip_S.text_L17419 not found in /lib/modules/2.2.16-22/net/old_tulip.o.  Ignoring /lib/modules/2.2.16-22/net/old_tulip.o entry
Warning: nls_cp437 symbol __insmod_nls_cp437_O/lib/modules/2.2.16-22/fs/nls_cp437.o_M39A2E18B_V131600 not found in /lib/modules/2.2.16-22/fs/nls_cp437.o.  Ignoring
/lib/modules/2.2.16-22/fs/nls_cp437.o entry
Warning: nls_cp437 symbol __insmod_nls_cp437_S.data_L3352 not found in /lib/modules/2.2.16-22/fs/nls_cp437.o.  Ignoring /lib/modules/2.2.16-22/fs/nls_cp437.o entry
Warning: nls_cp437 symbol __insmod_nls_cp437_S.rodata_L6 not found in /lib/modules/2.2.16-22/fs/nls_cp437.o.  Ignoring /lib/modules/2.2.16-22/fs/nls_cp437.o entry
Warning: nls_cp437 symbol __insmod_nls_cp437_S.text_L194 not found in /lib/modules/2.2.16-22/fs/nls_cp437.o.  Ignoring /lib/modules/2.2.16-22/fs/nls_cp437.o entry
Warning: vfat symbol __insmod_vfat_O/lib/modules/2.2.16-22/fs/vfat.o_M39A2E18B_V131600 not found in /lib/modules/2.2.16-22/fs/vfat.o.  Ignoring
/lib/modules/2.2.16-22/fs/vfat.o entry
Warning: vfat symbol __insmod_vfat_S.data_L336 not found in /lib/modules/2.2.16-22/fs/vfat.o.  Ignoring /lib/modules/2.2.16-22/fs/vfat.o entry
Warning: vfat symbol __insmod_vfat_S.rodata_L317 not found in /lib/modules/2.2.16-22/fs/vfat.o.  Ignoring /lib/modules/2.2.16-22/fs/vfat.o entry
Warning: vfat symbol __insmod_vfat_S.text_L8230 not found in /lib/modules/2.2.16-22/fs/vfat.o.  Ignoring /lib/modules/2.2.16-22/fs/vfat.o entry
Warning: fat symbol __insmod_fat_O/lib/modules/2.2.16-22/fs/fat.o_M39A2E18B_V131600 not found in /lib/modules/2.2.16-22/fs/fat.o.  Ignoring /lib/modules/2.2.16-22/fs/fat.o
entry
Warning: fat symbol __insmod_fat_S.bss_L2240 not found in /lib/modules/2.2.16-22/fs/fat.o.  Ignoring /lib/modules/2.2.16-22/fs/fat.o entry
Warning: fat symbol __insmod_fat_S.data_L1208 not found in /lib/modules/2.2.16-22/fs/fat.o.  Ignoring /lib/modules/2.2.16-22/fs/fat.o entry
Warning: fat symbol __insmod_fat_S.rodata_L2683 not found in /lib/modules/2.2.16-22/fs/fat.o.  Ignoring /lib/modules/2.2.16-22/fs/fat.o entry
Warning: fat symbol __insmod_fat_S.text_L22793 not found in /lib/modules/2.2.16-22/fs/fat.o.  Ignoring /lib/modules/2.2.16-22/fs/fat.o entry
Warning: opl3 symbol __insmod_opl3_O/lib/modules/2.2.16-22/misc/opl3.o_M39A2E18C_V131600 not found in /lib/modules/2.2.16-22/misc/opl3.o.  Ignoring
/lib/modules/2.2.16-22/misc/opl3.o entry
Warning: opl3 symbol __insmod_opl3_S.bss_L8 not found in /lib/modules/2.2.16-22/misc/opl3.o.  Ignoring /lib/modules/2.2.16-22/misc/opl3.o entry
Warning: opl3 symbol __insmod_opl3_S.data_L3028 not found in /lib/modules/2.2.16-22/misc/opl3.o.  Ignoring /lib/modules/2.2.16-22/misc/opl3.o entry
Warning: opl3 symbol __insmod_opl3_S.rodata_L807 not found in /lib/modules/2.2.16-22/misc/opl3.o.  Ignoring /lib/modules/2.2.16-22/misc/opl3.o entry
Warning: opl3 symbol __insmod_opl3_S.text_L7150 not found in /lib/modules/2.2.16-22/misc/opl3.o.  Ignoring /lib/modules/2.2.16-22/misc/opl3.o entry
Warning: sb symbol __insmod_sb_O/lib/modules/2.2.16-22/misc/sb.o_M39A2E18C_V131600 not found in /lib/modules/2.2.16-22/misc/sb.o.  Ignoring /lib/modules/2.2.16-22/misc/sb.o
entry
Warning: sb symbol __insmod_sb_S.bss_L2350 not found in /lib/modules/2.2.16-22/misc/sb.o.  Ignoring /lib/modules/2.2.16-22/misc/sb.o entry
Warning: sb symbol __insmod_sb_S.data_L6592 not found in /lib/modules/2.2.16-22/misc/sb.o.  Ignoring /lib/modules/2.2.16-22/misc/sb.o entry
Warning: sb symbol __insmod_sb_S.rodata_L3938 not found in /lib/modules/2.2.16-22/misc/sb.o.  Ignoring /lib/modules/2.2.16-22/misc/sb.o entry
Warning: sb symbol __insmod_sb_S.text_L20276 not found in /lib/modules/2.2.16-22/misc/sb.o.  Ignoring /lib/modules/2.2.16-22/misc/sb.o entry
Warning: uart401 symbol __insmod_uart401_O/lib/modules/2.2.16-22/misc/uart401.o_M39A2E18C_V131600 not found in /lib/modules/2.2.16-22/misc/uart401.o.  Ignoring
/lib/modules/2.2.16-22/misc/uart401.o entry
Warning: uart401 symbol __insmod_uart401_S.bss_L132 not found in /lib/modules/2.2.16-22/misc/uart401.o.  Ignoring /lib/modules/2.2.16-22/misc/uart401.o entry
Warning: uart401 symbol __insmod_uart401_S.data_L3020 not found in /lib/modules/2.2.16-22/misc/uart401.o.  Ignoring /lib/modules/2.2.16-22/misc/uart401.o entry
Warning: uart401 symbol __insmod_uart401_S.rodata_L576 not found in /lib/modules/2.2.16-22/misc/uart401.o.  Ignoring /lib/modules/2.2.16-22/misc/uart401.o entry
Warning: uart401 symbol __insmod_uart401_S.text_L1970 not found in /lib/modules/2.2.16-22/misc/uart401.o.  Ignoring /lib/modules/2.2.16-22/misc/uart401.o entry
Warning: sound symbol __insmod_sound_O/lib/modules/2.2.16-22/misc/sound.o_M39A2E18C_V131600 not found in /lib/modules/2.2.16-22/misc/sound.o.  Ignoring
/lib/modules/2.2.16-22/misc/sound.o entry
Warning: sound symbol __insmod_sound_S.bss_L5088 not found in /lib/modules/2.2.16-22/misc/sound.o.  Ignoring /lib/modules/2.2.16-22/misc/sound.o entry
Warning: sound symbol __insmod_sound_S.data_L2180 not found in /lib/modules/2.2.16-22/misc/sound.o.  Ignoring /lib/modules/2.2.16-22/misc/sound.o entry
Warning: sound symbol __insmod_sound_S.rodata_L3936 not found in /lib/modules/2.2.16-22/misc/sound.o.  Ignoring /lib/modules/2.2.16-22/misc/sound.o entry
Warning: sound symbol __insmod_sound_S.text_L42682 not found in /lib/modules/2.2.16-22/misc/sound.o.  Ignoring /lib/modules/2.2.16-22/misc/sound.o entry
Warning: soundlow symbol __insmod_soundlow_O/lib/modules/2.2.16-22/misc/soundlow.o_M39A2E18C_V131600 not found in /lib/modules/2.2.16-22/misc/soundlow.o.  Ignoring
/lib/modules/2.2.16-22/misc/soundlow.o entry
Warning: soundlow symbol __insmod_soundlow_S.text_L9 not found in /lib/modules/2.2.16-22/misc/soundlow.o.  Ignoring /lib/modules/2.2.16-22/misc/soundlow.o entry
Warning: soundcore symbol __insmod_soundcore_O/lib/modules/2.2.16-22/misc/soundcore.o_M39A2E18C_V131600 not found in /lib/modules/2.2.16-22/misc/soundcore.o.  Ignoring
/lib/modules/2.2.16-22/misc/soundcore.o entry
Warning: soundcore symbol __insmod_soundcore_S.bss_L68 not found in /lib/modules/2.2.16-22/misc/soundcore.o.  Ignoring /lib/modules/2.2.16-22/misc/soundcore.o entry
Warning: soundcore symbol __insmod_soundcore_S.data_L60 not found in /lib/modules/2.2.16-22/misc/soundcore.o.  Ignoring /lib/modules/2.2.16-22/misc/soundcore.o entry
Warning: soundcore symbol __insmod_soundcore_S.rodata_L281 not found in /lib/modules/2.2.16-22/misc/soundcore.o.  Ignoring /lib/modules/2.2.16-22/misc/soundcore.o entry
Warning: soundcore symbol __insmod_soundcore_S.text_L1275 not found in /lib/modules/2.2.16-22/misc/soundcore.o.  Ignoring /lib/modules/2.2.16-22/misc/soundcore.o entry
Warning: usb-uhci symbol __insmod_usb-uhci_O/lib/modules/2.2.16-22/usb/usb-uhci.o_M39A2E18B_V131600 not found in /lib/modules/2.2.16-22/usb/usb-uhci.o.  Ignoring
/lib/modules/2.2.16-22/usb/usb-uhci.o entry
Warning: usb-uhci symbol __insmod_usb-uhci_S.bss_L8 not found in /lib/modules/2.2.16-22/usb/usb-uhci.o.  Ignoring /lib/modules/2.2.16-22/usb/usb-uhci.o entry
Warning: usb-uhci symbol __insmod_usb-uhci_S.data_L84 not found in /lib/modules/2.2.16-22/usb/usb-uhci.o.  Ignoring /lib/modules/2.2.16-22/usb/usb-uhci.o entry
Warning: usb-uhci symbol __insmod_usb-uhci_S.rodata_L1863 not found in /lib/modules/2.2.16-22/usb/usb-uhci.o.  Ignoring /lib/modules/2.2.16-22/usb/usb-uhci.o entry
Warning: usb-uhci symbol __insmod_usb-uhci_S.text_L15183 not found in /lib/modules/2.2.16-22/usb/usb-uhci.o.  Ignoring /lib/modules/2.2.16-22/usb/usb-uhci.o entry
Warning: usbcore symbol __insmod_usbcore_O/lib/modules/2.2.16-22/usb/usbcore.o_M39A2E18B_V131600 not found in /lib/modules/2.2.16-22/usb/usbcore.o.  Ignoring
/lib/modules/2.2.16-22/usb/usbcore.o entry
Warning: usbcore symbol __insmod_usbcore_S.bss_L104 not found in /lib/modules/2.2.16-22/usb/usbcore.o.  Ignoring /lib/modules/2.2.16-22/usb/usbcore.o entry
Warning: usbcore symbol __insmod_usbcore_S.data_L1308 not found in /lib/modules/2.2.16-22/usb/usbcore.o.  Ignoring /lib/modules/2.2.16-22/usb/usbcore.o entry
Warning: usbcore symbol __insmod_usbcore_S.rodata_L8508 not found in /lib/modules/2.2.16-22/usb/usbcore.o.  Ignoring /lib/modules/2.2.16-22/usb/usbcore.o entry
Warning: usbcore symbol __insmod_usbcore_S.text_L29660 not found in /lib/modules/2.2.16-22/usb/usbcore.o.  Ignoring /lib/modules/2.2.16-22/usb/usbcore.o entry
Warning: cannot match loaded module aic7xxx to any module object.  Trace may not be reliable.
Dec 22 02:05:08 cr957697-a kernel: Unable to handle kernel paging request at virtual address 010ceac5
Dec 22 02:05:08 cr957697-a kernel: current->tss.cr3 = 01437000, %%cr3 = 01437000
Dec 22 02:05:08 cr957697-a kernel: *pde = 00000000
Dec 22 02:05:08 cr957697-a kernel: Oops: 0000
Dec 22 02:05:08 cr957697-a kernel: CPU:    0
Dec 22 02:05:08 cr957697-a kernel: EIP:    0010:[free_wait+58/108]
Dec 22 02:05:08 cr957697-a kernel: EFLAGS: 00210003
Dec 22 02:05:08 cr957697-a kernel: eax: 010ceac1   ebx: c2bc4160   ecx: c01200c4   edx: 010ceac1
Dec 22 02:05:08 cr957697-a kernel: esi: c2bc415c   edi: c2bc4000   ebp: 00200287   esp: c13f9f28
Dec 22 02:05:08 cr957697-a kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 02:05:08 cr957697-a kernel: Process X (pid: 1029, process nr: 48, stackpage=c13f9000)
Dec 22 02:05:08 cr957697-a kernel: Stack: c2bc4000 00000001 c012f331 c2bc4000 c2eed130 00000080 c2eed140 0000009f
Dec 22 02:05:08 cr957697-a kernel:        00000304 00000019 c13f8000 0001ce67 00000000 c2bc4000 c012f73e 00000019
Dec 22 02:05:08 cr957697-a kernel:        c13f9fa8 c13f9fa4 c13f8000 00000000 bffff7c8 bffff968 c2eed110 00000000
Dec 22 02:05:08 cr957697-a kernel: Call Trace: [do_select+493/516] [sys_select+1014/1360] [system_call+52/56]
Dec 22 02:05:08 cr957697-a kernel: Code: 8b 42 04 39 d8 75 f7 89 4a 04 55 9d 8b 06 50 e8 1e 77 ff ff

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:	8b 42 04             	mov    0x4(%edx),%eax <===
Code:  00000003 Before first symbol               3:	39 d8                	cmp    %ebx,%eax
Code:  00000005 Before first symbol               5:	75 f7                	jne     fffffffe <END_OF_CODE+3b68f4f6/???
Code:  00000007 Before first symbol               7:	89 4a 04             	mov    %ecx,0x4(%edx)
Code:  0000000a Before first symbol               a:	55                   	push   %ebp
Code:  0000000b Before first symbol               b:	9d                   	popf   
Code:  0000000c Before first symbol               c:	8b 06                	mov    (%esi),%eax
Code:  0000000e Before first symbol               e:	50                   	push   %eax
Code:  0000000f Before first symbol               f:	e8 1e 77 ff ff       	call    ffff7732 <END_OF_CODE+3b686c2a/???

Dec 22 02:05:08 cr957697-a kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000398
Dec 22 02:05:08 cr957697-a kernel: current->tss.cr3 = 02c3e000, %%cr3 = 02c3e000
Dec 22 02:05:08 cr957697-a kernel: *pde = 00000000
Dec 22 02:05:09 cr957697-a kernel: Oops: 0000
Dec 22 02:05:09 cr957697-a kernel: CPU:    0
Dec 22 02:05:09 cr957697-a kernel: EIP:    0010:[__wake_up+30/72]
Dec 22 02:05:09 cr957697-a kernel: EFLAGS: 00010287
Dec 22 02:05:09 cr957697-a kernel: eax: 00000004   ebx: 010ceac1   ecx: c3182e00   edx: 00000398
Dec 22 02:05:09 cr957697-a kernel: esi: c09202d4   edi: 00000001   ebp: c2617e70   esp: c2617e6c
Dec 22 02:05:09 cr957697-a kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 02:05:09 cr957697-a kernel: Process realplay (pid: 3291, process nr: 79, stackpage=c2617000)
Dec 22 02:05:09 cr957697-a kernel: Stack: 00000d68 c2617ea4 c014dc39 c2eeb6e0 c017f37d c37d5c40 00000d68 c1cf291c
Dec 22 02:05:09 cr957697-a kernel:        c2617f04 c017f140 00000246 00000000 c3182e00 00000246 c1cf291c c014bb08
Dec 22 02:05:09 cr957697-a kernel:        c1cf291c c2617f04 00000d68 c2617ed8 c1cf291c 00000d68 c1cf2880 00000002
Dec 22 02:05:09 cr957697-a kernel: Call Trace: [sock_def_readable+25/48] [unix_stream_sendmsg+573/608] [unix_stream_sendmsg+0/608] [sock_sendmsg+136/172]
[unix_stream_sendmsg+0/608] [sock_readv_writev+128/140] [do_readv_writev+365/516]
Dec 22 02:05:09 cr957697-a kernel: Code: 8b 02 85 f8 74 f1 39 f3 74 0c 89 d0 e8 45 fa ff ff eb e4 8d

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:	8b 02                	mov    (%edx),%eax <===
Code:  00000002 Before first symbol               2:	85 f8                	test   %edi,%eax
Code:  00000004 Before first symbol               4:	74 f1                	je      fffffff7 <END_OF_CODE+3b68f4ef/???
Code:  00000006 Before first symbol               6:	39 f3                	cmp    %esi,%ebx
Code:  00000008 Before first symbol               8:	74 0c                	je      00000016 Before first symbol
Code:  0000000a Before first symbol               a:	89 d0                	mov    %edx,%eax
Code:  0000000c Before first symbol               c:	e8 45 fa ff ff       	call    fffffa56 <END_OF_CODE+3b68ef4e/???
Code:  00000011 Before first symbol              11:	eb e4                	jmp     fffffff7 <END_OF_CODE+3b68f4ef/???
Code:  00000013 Before first symbol              13:	8d 00                	lea    (%eax),%eax


92 warnings and 6 errors issued.  Results may not be reliable.

-- 
Bill K.  (billy@spamcop.net)
**** WARNING ****  All unsolicited bulk e-mail received at this address
will be promptly reported to the sender's system administrator, and to 
law enforcement authorities whenever applicable.
(Done through SpamCop.  See http://spamcop.net for details.)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
