Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265778AbUA1BTf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 20:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265797AbUA1BTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 20:19:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:19085 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265778AbUA1BT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 20:19:29 -0500
Date: Tue, 27 Jan 2004 17:14:27 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: kjo <kernel-janitors@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] 2.6.2-rc2-kj1 patchset
Message-Id: <20040127171427.24f62515.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(fairly small this time, several patches recently merged,
and I'm still reviewing others.)


patch is at:
http://developer.osdl.org/rddunlap/kj-patches/2.6.2-rc2/2.6.2-rc2-kj1.patch.bz2  [2004-01-27]

M: merged at kernel.org;   mm: in -mm;   tx: sent;   mntr: maintainer merged;

This patch applies to linux-2.6.2-rc2.

new (for 2.6.2-rc2):  [2004-01-27]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
add/	ide_pci_triflex_not_procfs.patch
	From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>

add/	ps2esdi_typos.patch
	From: Timmy Yee <shoujun@masterofpi.org>

add/	fbcmap_kmalloc.patch
	From: Leann Ogasawara <ogasawara@osdl.org>

add	vga16fb_audit.patch
	From: Leann Ogasawara <ogasawara@osdl.org>

previous (for 2.6.2-rc1):  [2004-01-23] [not announced]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tx/	errno_numbers_assembly.patch
	From: Danilo Piazzalunga <danilopiazza@libero.it>
	to akpm: 2004.0126;

drop/	ide_tape_kmalloc_fail.patch
	From: Eugene Teo <eugene.teo@eugeneteo.net>
	looks wrong:  can't just return without doing work;

mm/	linux_sound_c99_init.patch
	From: "Maciej Soltysiak" <solt@dns.toxicfilms.tv>
	to akpm/perex: 2004.0124;

drop/	parameter_typos.patch
	From: "Maciej Soltysiak" <solt@dns.toxicfilms.tv>
	don't worry about spellos in comments;

previous (for 2.6.1-bk6):  [2004-01-21]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tx/	aha1542_kmalloc_type.patch
	From: Timmy Yee <shoujun@masterofpi.org>
	to linux-scsi 2004.0124;

tx/	aha1542_qcommand_return.patch
	From: Timmy Yee <shoujun@masterofpi.org>
	to linux-scsi 2004.0124;

mm/	char_dz_vrfy_area.patch
	From: Domen Puncer <domen@coderock.org>
	to akpm: 2004.0124;

mm/	config_sysrq.patch
	From: Domen Puncer <domen@coderock.org>
	to akpm: 2004.0124;

mntr/	mcfserial_remove_casts_args.patch
	From: Domen Puncer <domen@coderock.org>
	to gerg@snapgear.com 2004.0124;

mntr/	netdev_get_stats.patch
	From: Domen Puncer <domen@coderock.org>
	to netdev/davem: 2004.0124;

tx/	scsi_config_doc.patch
	From: Jean Delvare <khali@linux-fr.org>
	to linux-scsi 2004.0124;

mntr/	saa7146_hlp_min_max.patch
	From: Eugene Teo <eugene.teo@eugeneteo.net>
	to maint: 2004.0124;

previous (for 2.6.1-bk4):  [2004-01-16]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mntr/	config_ledman_rm.patch
	From: Domen Puncer <domen@coderock.org>
	to gerg@snapgear.com 2004.0124;

mntr/	ipt_register_target_retval.patch
	From: Daniele Bellucci <bellucda@tiscali.it>
	to netdev/davem: 2004.0124;

drop/	kconfig_cleanups_v1.patch
	From: Matthew Wilcox <willy@debian.org>
  drop	drivers/block/Kconfig: merge conflicts
  drop	drivers/video/console/Kconfig: merge conflicts
  drop	drivers/i2c/*/Kconfig: already merged
  	Willy to handle with akpm.

add?	kswapd_init_fail.patch
	From: Eugene Teo <eugene.teo@eugeneteo.net>

add/	lmc_proto_raw_h_rm.patch
	From: Domen Puncer <domen@coderock.org>

mntr/	netdev_rm_casts.patch
	From: Carlo Perassi <carlo@linux.it>
	to netdev/jgarzik: 2004.0124;

mntr/	s390_net_ctctty_putuser.patch
	From: Domen Puncer <domen@coderock.org>
	(rediffed)
	sent to s390 mntr: 2004.0124;

add/	setup_bootmem_fail.patch
	From: Eugene Teo <eugene.teo@eugeneteo.net>

?add	skfddi_regions_pciupdate.patch
	From: Matthew Wilcox <willy@debian.org>

drop/	acpi_boot_message_typo.patch
	From: Simon Richard Grint <rgrint@mrtall.compsoc.man.ac.uk>
	no longer applicable: function was removed;

mntr/	cpcihp_zt5550_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>
	to gregkh: 2004.0124;

mntr/	mfcserial_vrfyarea.patch
	From: Domen Puncer <domen@coderock.org>
	to gerg@snapgear.com 2004.0124;

tx/	vga16fb.c_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>
	to akpm/mntr: 2004.0126;

tx/	vgastate.c_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>
	to akpm/mntr: 2004.0126;

drop/	tc35815.c_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>
	sent to jgarzik/netdev: 2004.0118;
	already in netdev patchset;

drop/	depca_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>
	already in netdev patchset;

tx/	dgrs_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>
	sent to jgarzik/netdev: 2004.0118;

###


--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
