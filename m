Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTIZAoP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 20:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbTIZAoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 20:44:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:43480 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262095AbTIZAoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 20:44:00 -0400
Date: Thu, 25 Sep 2003 17:36:36 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: kjo <kernel-janitors@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] 2.6.0-test5-bk12-kj patchset
Message-Id: <20030925173636.6bb56310.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(i know, too many hyphens and abbreviations...)


patch is at:
http://developer.osdl.org/rddunlap/kj-patches/2.6.0-test5-kj3/patch-2.6.0-test5-kj.bz2  [2003-09-25]

This is an update to patch-2.6.0-test5-kj2.
This patch applies to linux-2.6.0-test5-bk12.

changes since patch-2.6.0-test4-bk4-kj1:  [2003-09-16]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
add/	update EXTRAVERSION: add -kj
/

rediff/	scsi_sg_register.patch
	From: Daniele Bellucci <bellucda@tiscali.it>
TX to jejb/scsi: 2003.0917;

keep/	printk KERN_* constants in Documentation/
	"Warren A. Layton" <zeevon@debian.org>

rediff/	devfs_cdev_misc_reg.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

keep/	dvb_av7110_retval.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

keep/	dvb_budget_2.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

keep/	dvb_budget_retval.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

keep/	dvb_budget_ci_retval.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

keep/	dvb_ttusb_copyuser.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

keep/	opl3sa2_cleanups.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

keep/	sound_use_strsep.patch
	From: maximilian attems <janitor@sternwelten.at>

add/	char_riolinux_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	char_sx_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	coda_upcall_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	h8300_ptrace_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	isdn_common_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	isdn_hisax_isar_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	net_bluetooth_hcicore_verify.patch
	From: Domen Puncer <domen@coderock.org>

???	net_wan_sbni_verify.patch
	From: Domen Puncer <domen@coderock.org>
!patch failure!

add/	net_wireless_orinoco_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	ppc_syscalls_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	s390_net_ctctty_verify.patch
	From: Domen Puncer <domen@coderock.org> and Randy Dunlap

add/	sbus_jsflash_verify.patch
	From: Domen Puncer <domen@coderock.org> and Randy Dunlap

add/	serial_68328_verify.patch
	From: Domen Puncer <domen@coderock.org> and Randy Dunlap

add/	serial_mcfserial_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	serial_tx3912_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	sound_cmipci_procfs2.patch
	From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>

add	version-patches-b.tar.bz2
/	version_drivers_media_video.patch
TX to LT: 2003.0917;
/	version_drivers_scsi.patch
TX to jejb/scsi: 2003.0917;
/	version_sound_oss.patch
TX to LT/perex: 2003.0917;
/	version_drivers_telephony.patch
TX to LT: 2003.0917;
/	version_drivers_video.patch
TX to LT/maints: 2003.0917;
	From: Randy Hron <rwhron@earthlink.net>

add/	drivers_media_version.patch
TX to LT: 2003.0917;
/	drivers_isdn_version.patch
TX to maintainers: 2003.0917;
/	drivers_char_version.patch
TX to LT: 2003.0917;
/	fs_intermezzo_includes.patch
TX to m-l & LT: 2003.0917;
	From: Randy Hron <rwhron@earthlink.net>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
New for -kj2:

add/	printk_newlines.patch
	From: maximilian attems <janitor@sternwelten.at>
TX to LT & ak: 2003.0917;

add:	version3.tar.bz2
	version4.tar.bz2
/	version_drivers_mtd.patch
TX to dwmw2: 2003.0917;
/	version_drivers_pcmcia.patch
TX to rmk: 2003.0917;
/	version_drivers_s390.patch
TX/M/ to S390 maint: 2003.0917;
some merged
/	version_oss_dmasound.patch (needs 260-test5-bk3)
/	version_drivers_cdrom.patch
TX to maint & LT: 2003.0917;
	From: Randy Hron <rwhron@earthlink.net>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
New for -kj3:
(I still need to review all of these in detail.)

/	arch_arm_common_taskrun.patch
/	atm_he_taskrun.patch
/	base_bus_extra.patch
/	block_cciss_procfs.patch
/	block_cpqarray_procfs.patch
/	char_toshiba_procfs.patch
/	drivers_char_taskrun.patch
/	fs_all_includes.patch
/	fs_nfsd_register.patch
/	fs_nfsd_taskrun.patch
/	net_all_taskrun.patch
/	net_e100_includes.patch
/	net_natsemi_iounmap.patch
/	net_wan_taskrun.patch
/	pnpbios_procfs.patch (updated by rddunlap)
/	sbus_char_taskrun.patch
/	scsi_a3000_includes.patch
/	scsi_dpt_includes.patch
/	scsi_in2000_includes.patch
/	scsi_megaraid_includes.patch
/	scsi_osst_includes.patch
/	scsi_sym53c416_includes.patch
/	serial_core_taskrun.patch
/	serial_mcf_includes.patch
/	sound_all_taskrun.patch
/	tc_zs_includes.patch
/	video_sa1100fb_taskrun.patch
/	include_includes.patch

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Merged:

add/	input_init_procfs2.patch
	From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
TX/M/ to LT/vojtech: 2003.0917;

add/	input_noprocfs.patch
	From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
TX/M/ to LT/vojtech: 2003.0917;

add/	net_ns83820_err_handling.patch
	From: Leann Ogasawara <ogasawara@osdl.org>
TX/M/ to jgarzik/netdev: 2003.0917;

add/	net_rcpci_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>
TX/M/ to jgarzik/netdev: 2003.0917;

/	version_sound_drivers.patch
TX/M/ to LT/maints: 2003.0917;
/	version_net.patch
TX/M/ to jgarzik/netdev: 2003.0917;
/	version_net_wanrouter.patch
TX/M/ to jgarzik/netdev: 2003.0917;
/	version_wireless.patch
TX/M/ to jgarzik/netdev/jt: 2003.0917;
/	version_sk98lin.patch
TX/M/ to jgarzik/netdev: 2003.0917;
/	version_skfp.patch
TX/M/ to jgarzik/netdev: 2003.0917;
merged:	rh_version2.tar.bz2
/	drivers_net_wan.patch
TX/M/ to jgarzik/netdev: 2003.0917;
/	drivers_net_hamradio.patch
TX/M/ to jgarzik/netdev: 2003.0917;
/	drivers_net_tokenring.patch
TX/M/ to jgarzik/netdev/maint: 2003.0917;
	From: Randy Hron <rwhron@earthlink.net>
/	version_drivers_usb.patch
TX/M/ to gkh: 2003.0917;
/	version_sbus_char.patch
TX/M/ to Pete/davem: 2003.0917;
/	version_drivers_pnp_isapnp.patch
TX/M/ to LT/perex: 2003.0917;

*	rm_last_SMP.patch (by rddunlap)
TX/M to akpm: 2003.0918;

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Dropped:

/	char_toshiba_noprocfs.patch
	From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
drop/	changes behavior in a bad way;

add/	char_dz_verify.patch
	From: Domen Puncer <domen@coderock.org>
drop/	for serial rewrite;

drop/	net_ipv4_route_noproc.patch
	From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
already merged (Dave Jones)

X	version_net_sched.patch
already merged;

add/	SMP_removal_last.patch
	From: Adrian Bunk <bunk@fs.tum.de>
lines deleted instead;

###

--
~Randy
