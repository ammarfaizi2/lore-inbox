Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbUCJAIc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 19:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbUCJAIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 19:08:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:50818 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262540AbUCJAIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 19:08:13 -0500
Date: Tue, 9 Mar 2004 16:06:39 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: kjo <kernel-janitors@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] 2.6.4-rc2-kj1 patchset
Message-Id: <20040309160639.4c3b3bcc.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


patch is at:
http://developer.osdl.org/rddunlap/kj-patches/2.6.4-rc2/2.6.4-rc2-kj1.patch.bz2  [2004-03-09]

M: merged at kernel.org;   mm: in -mm;   tx: sent;   mntr: maintainer merged;

This patch applies to linux-2.6.4-rc2.
new (for 2.6.4-rc2):  [2004-03-09]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

add/	extraver.patch
	rddunlap%osdl!org

add/	kswapd_init_fail.patch
	From: Eugene Teo <eugene.teo@eugeneteo.net>

tx/	lmc_proto_raw_h_rm.patch
	From: Domen Puncer <domen@coderock.org>
	sent to netdev/jgarzik: 2004.0229;

drop/	setup_bootmem_fail.patch
	From: Eugene Teo <eugene.teo@eugeneteo.net>
	don't bother;

drop/	posix_timers_kmemcc.patch
	From: <WHarms@bfs.de>(Walter Harms)
	sent to akpm: 2004.0220;
	don't bother;

add/	atm_nicstar_minmax.patch
	From: Michael Veeck <michael.veeck@gmx.net>
	sent to netdev/mntr: 2004.0225;

mm/	genrtc_proc.patch
	From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>
	From: Randy.Dunlap <rddunlap%osdl!org>
	sent to akpm: 2004.0225;

add/	ipv4_fib_hash_check.patch
	From: Francois Romieu <romieu@fr.zoreil.com>
	original From: <WHarms@bfs.de>(Walter Harms)

add/	file2alias_signcomp.patch
fxd	From: Ron Gage <ron@rongage.org>

add/	fixdep_signcomp.patch
fxd	From: Ron Gage <ron@rongage.org>

add/	modpost_signcomp.patch
	From: Ron Gage <ron@rongage.org>

tx/	errno_numbers_assembly.patch
	From: Danilo Piazzalunga <danilopiazza@libero.it>
	to akpm: 2004.0126;

tx/	dgrs_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>
	sent to jgarzik/netdev: 2004.0124;

add/	doc_var_updates.patch
	From: Alexey Dobriyan <adobriyan@mail.ru>

add/	drivers_ide_minmax.patch
	From: Michael Veeck <michael.veeck@gmx.net>

add/	drivers_ide_minmax2.patch
	From: Michael Veeck <michael.veeck@gmx.net>

add/	fs_proc_minmax.patch
	From: Michael Veeck <michael.veeck@gmx.net>

add/	mm_slab_init.patch
	From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>

add/	reiserfs_minmax.patch
	From: Michael Veeck <michael.veeck@gmx.net>

add/	serial_8250_pnp_init.patch
	From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>

add/	sound_oss_minmax.patch
	From: Michael Veeck <michael.veeck@gmx.net>

add/	zlib_deflate_minmax.patch
	From: Michael Veeck <michael.veeck@gmx.net>

add/	char_ip2_double_op.patch
	From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>

add/	keyboard_ptr_to_string.patch
	From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>

add/	string_form_drivers.patch
	From: maximilian attems <janitor@sternwelten.at>

###

backlog:
. check kernel_thread() results;
. list_for_each() usage;
. floppy.c cleanups;

other:
There are about 80 "remove unneeded cast" patches in the netdev
queue awaiting a reply.  I'm not continuing to keep them in -kj
for now.

###

--
~Randy
