Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269878AbTGLHwf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 03:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269973AbTGLHwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 03:52:35 -0400
Received: from air-2.osdl.org ([65.172.181.6]:37579 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269878AbTGLHwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 03:52:32 -0400
Message-ID: <32820.4.4.25.4.1057997224.squirrel@www.osdl.org>
Date: Sat, 12 Jul 2003 01:07:04 -0700 (PDT)
Subject: 2.5.75-kj1
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
Cc: <kernel-janitor-discuss@lists.sourceforge.net>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


patch is at:
http://developer.osdl.org/rddunlap/kj-patches/2.5.75/patch-2.5.75-kj1.bz2

changes since patch-2.5.74-kj1:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drop/	typo-usb-serial-kconfig.patch
	Francois Romieu <romieu@fr.zoreil.com>
	incorrect

add/	teleph_ixj3.patch: audit+cleanup+cod. style
	Daniele Bellucci <bellucda@tiscali.it>

add/	Netwinder wdt977 msic_register audit
	Daniele Bellucci <bellucda@tiscali.it>

add/	media/video/pms.c copy_from_user audit
	Daniele Bellucci <bellucda@tiscali.it>

add/	net/irda/vlsi_ir.c copy_from_user audit
	Daniele Bellucci <bellucda@tiscali.it> and
	Mathew Wilcox <willy@debian.org>

add/	audit copy_to_user in net/wireless/ray_cs.c
	Daniele Bellucci <bellucda@tiscali.it>

add/	Audit copy_to_user/put_user in fs/umsdos/ioctl.c
	Daniele Bellucci <bellucda@tiscali.it>

add/	Audit + cleanup in drivers/sbus/char/envctrl.c
	Daniele Bellucci <bellucda@tiscali.it>

add/	Audit copy_from_user in drivers/ieee1394/amdtp.c
	Daniele Bellucci <bellucda@tiscali.it>

add/	Audit copy_from_user in drivers/parisc/led.c
	Daniele Bellucci <bellucda@tiscali.it>

add/	audit copy_from_user and fixed memory leak in drivers/net/comx-hw-comx.c
	Daniele Bellucci <bellucda@tiscali.it>
add/	printk KERN_* constants in Documentation/
	"Warren A. Layton" <zeevon@debian.org>

add/	KERN_* constants in all printk calls in arch/m68knommu:
	"Warren A. Layton" <zeevon@debian.org>

changes since patch-2.5.73-kj1:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drop/	unused_var_drivers_serial_8250_cs.patch
	Daniele Bellucci <bellucda@tiscali.it>
	already in 2.5.75

add/	unchkd_return_copy_from_user_net_core_pktgen.c
	Steffen Klassert <klassert@mathematik.tu-chemnitz.de>

add/	pci_name_diff.txt
	"Warren A. Layton" <zeevon@debian.org>

add/	uninit_static_misc.patch
	uninit_static_sound.patch
	uninit_static_fs.patch
	uninit_static_net.patch
	Leann Ogasawara

changes since patch-2.5.70-bk13-kj:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

drop/	je_cpqarray_fix_stack_usage.patch
	Jorn Engel and Randy Dunlap
	merged by akpm on 2003-06-10 (in 2.5.71)

keep/	je_wanrouter_fix_stack_usage.patch
	Jorn Engel and Randy Dunlap

add/	unchecked_copytouser.patch
	in fs/proc_misc.c: Daniele Belluci

add/	busmouse_retcode_memleak.patch
	Flavio B. Leitner

###

Still more in the queue.

~Randy



