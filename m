Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbRAWKrr>; Tue, 23 Jan 2001 05:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129806AbRAWKrk>; Tue, 23 Jan 2001 05:47:40 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:57837 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S129747AbRAWKrb>; Tue, 23 Jan 2001 05:47:31 -0500
Date: Tue, 23 Jan 2001 10:48:14 +0000
From: Anders Karlsson <anders.karlsson@meansolutions.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.0-ac10 compile errors
Message-ID: <20010123104814.A2937@alien.ssd.hursley.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alan,
    =20
I have some small problems compiling the 2.4.0-ac10 kernel         =20
tree. Please find attached a compile log and the output from the
/usr/src/linux/scripts/ver_linux script.
    =20
The procedure I have gone through to compile the kernel are as
follows:
    =20
a) Copy the .config file safe
b) Remove the previous kernel tree
c) Extract the pristine 2.4.0 kernel tree
d) Apply the 2.4.0-ac10 patch
e) Copy the .config in to the new /usr/src/linux tree          =20
f) make oldconfig
g) make dep
h) make bzImage
    =20
What is it I have missed out in the list that would cause the
problems?
    =20
Regards,
    =20
--
        Anders Karlsson

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.0-ac10-versions.txt"

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux alien 2.4.0-ac9 #8 Thu Jan 18 09:52:13 GMT 2001 i686 unknown
Kernel modules         2.3.17
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.0.26
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.7
Mount                  2.10o
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         ipt_REDIRECT ipt_MASQUERADE ip_nat_ftp iptable_nat iptable_mangle iptable_filter ipt_unclean ipt_tos ipt_state ipt_owner ipt_multiport ipt_mark ipt_mac ipt_limit ipt_TOS ipt_REJECT ipt_MIRROR ipt_MARK ipt_LOG ip_tables ip_conntrack_ftp ip_conntrack tulip_cb cb_enabler ibmtr_cs ds i82365 pcmcia_core mpu401 sb sb_lib uart401 sound soundcore

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.0-ac10-compile.err"

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686   -c -o init/main.o init/main.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686  -DUTS_MACHINE='"i386"' -c -o init/version.o init/version.c
make CFLAGS="-D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 " -C  kernel
make[1]: Entering directory `/usr/src/linux.ac/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux.ac/kernel'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c signal.c
In file included from /usr/src/linux/include/linux/module.h:21,
                 from signal.c:11:
/usr/src/linux/include/linux/modversions.h:4: linux/modules/8390.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:5: linux/modules/ac97_codec.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:6: linux/modules/ac97.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:7: linux/modules/acpi_ksyms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:8: linux/modules/ad1848.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:9: linux/modules/adb.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:10: linux/modules/af_ax25.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:11: linux/modules/af_ipx.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:12: linux/modules/af_netlink.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:13: linux/modules/af_spx.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:14: linux/modules/agpgart_be.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:15: linux/modules/aironet4500_card.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:16: linux/modules/aironet4500_core.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:17: linux/modules/amd7930.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:18: linux/modules/arcnet.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:19: linux/modules/arlan.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:20: linux/modules/atm_misc.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:21: linux/modules/audio_syms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:22: linux/modules/audio.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:23: linux/modules/auto_irq.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:24: linux/modules/b1dma.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:25: linux/modules/b1pcmcia.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:26: linux/modules/b1.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:27: linux/modules/base.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:28: linux/modules/blkpg.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:29: linux/modules/bttv-if.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:30: linux/modules/busmouse.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:31: linux/modules/capifs.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:32: linux/modules/capiutil.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:33: linux/modules/cb_enabler.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:34: linux/modules/cdrom.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:35: linux/modules/check.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:36: linux/modules/cmdline.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:37: linux/modules/com20020.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:38: linux/modules/common.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:39: linux/modules/comx.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:40: linux/modules/config.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:41: linux/modules/console.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:42: linux/modules/context.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:43: linux/modules/cpia.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:44: linux/modules/cpuid.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:45: linux/modules/cs.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:46: linux/modules/cyber2000fb.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:47: linux/modules/cycx_drv.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:48: linux/modules/DAC960.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:49: linux/modules/dbri.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:50: linux/modules/ddp.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:51: linux/modules/Divas_mod.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:52: linux/modules/dmasound_core.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:53: linux/modules/ds.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:54: linux/modules/eicon_mod.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:55: linux/modules/fatfs_syms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:56: linux/modules/fbcmap.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:57: linux/modules/fbcon-afb.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:58: linux/modules/fbcon-cfb16.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:59: linux/modules/fbcon-cfb24.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:60: linux/modules/fbcon-cfb2.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:61: linux/modules/fbcon-cfb32.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:62: linux/modules/fbcon-cfb4.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:63: linux/modules/fbcon-cfb8.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:64: linux/modules/fbcon-hga.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:65: linux/modules/fbcon-ilbm.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:66: linux/modules/fbcon-iplan2p2.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:67: linux/modules/fbcon-iplan2p4.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:68: linux/modules/fbcon-iplan2p8.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:69: linux/modules/fbcon-mac.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:70: linux/modules/fbcon-mfb.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:71: linux/modules/fbcon.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:72: linux/modules/fbcon-vga-planes.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:73: linux/modules/fbcon-vga.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:74: linux/modules/fbmem.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:75: linux/modules/fbmon.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:76: linux/modules/fc_syms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:77: linux/modules/ffb_drv.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:78: linux/modules/filesystems.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:79: linux/modules/ftape_syms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:80: linux/modules/gameport.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:81: linux/modules/gamma_drv.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:82: linux/modules/hdlcdrv.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:83: linux/modules/hdlc.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:84: linux/modules/i2c-algo-bit.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:85: linux/modules/i2c-algo-pcf.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:86: linux/modules/i2c-core.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:87: linux/modules/i2c-old.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:88: linux/modules/i2o_block.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:89: linux/modules/i2o_config.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:90: linux/modules/i2o_core.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:91: linux/modules/i2o_lan.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:92: linux/modules/i2o_pci.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:93: linux/modules/i2o_proc.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:94: linux/modules/i2o_scsi.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:95: linux/modules/i386_ksyms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:96: linux/modules/i810_drv.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:97: linux/modules/ide-features.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:98: linux/modules/ide.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:99: linux/modules/idt77105.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:100: linux/modules/ieee1394_syms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:101: linux/modules/init.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:102: linux/modules/input.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:103: linux/modules/ipcommon.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:104: linux/modules/ip_conntrack_ftp.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:105: linux/modules/ip_conntrack_standalone.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:106: linux/modules/ip_fw_compat.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:107: linux/modules/ip_gre.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:108: linux/modules/ipip.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:109: linux/modules/ip_nat_standalone.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:110: linux/modules/ip_tables.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:111: linux/modules/irport.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:112: linux/modules/irsyms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:113: linux/modules/isapnp.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:114: linux/modules/isdn_common.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:115: linux/modules/isense.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:116: linux/modules/jedec.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:117: linux/modules/kcapi.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:118: linux/modules/keyboard.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:119: linux/modules/kmod.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:120: linux/modules/ksyms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:121: linux/modules/lapb_iface.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:122: linux/modules/llc_macinit.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:123: linux/modules/ll_rw_blk.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:124: linux/modules/lockd_syms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:125: linux/modules/loop.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:126: linux/modules/mac_hid.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:127: linux/modules/matroxfb_accel.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:128: linux/modules/matroxfb_base.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:129: linux/modules/matroxfb_DAC1064.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:130: linux/modules/matroxfb_misc.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:131: linux/modules/matroxfb_Ti3026.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:132: linux/modules/mca.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:133: linux/modules/md.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:134: linux/modules/mga_drv.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:135: linux/modules/microcode.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:136: linux/modules/midi_syms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:137: linux/modules/misc.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:138: linux/modules/modedb.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:139: linux/modules/mptbase.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:140: linux/modules/mptctl.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:141: linux/modules/mptlan.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:142: linux/modules/mptscsih.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:143: linux/modules/mpu401.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:144: linux/modules/msdosfs_syms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:145: linux/modules/msnd.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:146: linux/modules/msr.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:147: linux/modules/mtdcore.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:148: linux/modules/mtdpart.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:149: linux/modules/mtrr.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:150: linux/modules/netfilter.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:151: linux/modules/netsyms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:152: linux/modules/nls_base.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:153: linux/modules/nm256_audio.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:154: linux/modules/nubus_syms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:155: linux/modules/open.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:156: linux/modules/opl3.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:157: linux/modules/p8022.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:158: linux/modules/parport_pc.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:159: linux/modules/pci_socket.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:160: linux/modules/pci.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:161: linux/modules/phonedev.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:162: linux/modules/pm.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:163: linux/modules/ppp_async.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:164: linux/modules/ppp_generic.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:165: linux/modules/pppox.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:166: linux/modules/procfs_syms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:167: linux/modules/proc.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:168: linux/modules/profile.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:169: linux/modules/psnap.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:170: linux/modules/pty.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:171: linux/modules/r128_drv.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:172: linux/modules/random.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:173: linux/modules/raw.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:174: linux/modules/ray_cs.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:175: linux/modules/resources.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:176: linux/modules/rtc.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:177: linux/modules/sb_common.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:178: linux/modules/scsi_syms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:179: linux/modules/sdladrv.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:180: linux/modules/selection.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:181: linux/modules/sequencer_syms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:182: linux/modules/serial.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:183: linux/modules/serio.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:184: linux/modules/signal.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:185: linux/modules/slhc.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:186: linux/modules/sound_core.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:187: linux/modules/sound_syms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:188: linux/modules/suni.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:189: linux/modules/sunrpc_syms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:190: linux/modules/su.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:191: linux/modules/syncppp.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:192: linux/modules/sysrq.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:193: linux/modules/sys.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:194: linux/modules/tdfx_drv.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:195: linux/modules/tms380tr.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:196: linux/modules/tty_io.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:197: linux/modules/uart401.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:198: linux/modules/uPD98402.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:199: linux/modules/usbserial.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:200: linux/modules/usb.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:201: linux/modules/util.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:202: linux/modules/vfatfs_syms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:203: linux/modules/videodev.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:204: linux/modules/wanmain.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:205: linux/modules/xor.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:206: linux/modules/yenta.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:207: linux/modules/z85230.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:208: linux/modules/zftape_syms.ver: No such file or directory
/usr/src/linux/include/linux/modversions.h:209: linux/modules/zorro.ver: No such file or directory
make[2]: *** [signal.o] Error 1
make[2]: Leaving directory `/usr/src/linux.ac/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux.ac/kernel'
make: *** [_dir_kernel] Error 2

--qMm9M+Fa2AknHoGS--

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjptYWwACgkQhWP0bzSeaGPUdgCg6xMA9PmcsLYHofELTNek9xFJ
mqcAn1Qv26LGwsdnxb7cPZPTQGUCVnkV
=hl32
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
