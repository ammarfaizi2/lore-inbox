Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266609AbUGKOyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266609AbUGKOyU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 10:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266610AbUGKOyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 10:54:20 -0400
Received: from ns3.factline.com ([213.239.193.148]:43668 "EHLO
	ns3.factline.com") by vger.kernel.org with ESMTP id S266609AbUGKOyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 10:54:03 -0400
Date: Sun, 11 Jul 2004 16:53:58 +0200
From: maximilian attems <janitor@sternwelten.at>
To: kj <kernel-janitors@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [announce] 2.6.7-kjt2 patchset
Message-ID: <20040711145358.GG1828@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

lots under driver/chars thanks to min/max cleanup by Michael Veeck,
when applying splitted out patches take care of the order.
they apply to current linus tree 2.6.7-bk20.

thanks to Randy for help and detailed guide for merging patches.
will make it easier for this one.
patches will be sent to MAINTAINERS in 2-3 days..

the new patch is at:
http://debian.stro.at/kjt/2.6.7-kjt2/2.6.7-kjt2.patch.bz2

splitted patches:
http://debian.stro.at/kjt/2.6.7-kjt2/split/

a++ maks


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
added since 2.6.7-kjt1

min-max-char_amiserial.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/char/amiserial.c MIN/MAX removal

min-max-char_epca.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/char/epca.c MIN/MAX removal

min-max-char_esp.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/char/esp.c MIN/MAX removal

min-max-char_isicom.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/char/isicom.c MIN/MAX removal

min-max-char_mxser.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/char/mxser.c MIN/MAX removal

min-max-char_pcmcia_synclink_cs.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/char/pcmcia/synclink_cs.c MIN/MAX 	removal

min-max-char_pcxx.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/char/pcxx.c MIN/MAX removal

min-max-char_riscom8.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/char/riscom8.c MIN/MAX removal

min-max-char_rocket.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/char/rocket.c MIN/MAX removal

min-max-char_rocket_int.h.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/char/rocket_int.h MIN/MAX removal

min-max-char_selection.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/char/selection.c MIN/MAX removal

min-max-char_serial167.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/char/serial167.c MIN/MAX removal

min-max-char_specialix.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/char/specialix.c MIN/MAX removal

min-max-char_synclink.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/char/synclink.c MIN/MAX removal

min-max-char_synclinkmp.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/char/synclinkmp.c MIN/MAX removal

min-max-ide_ide-timing.h.patch
  From: Clemens Buchacher <drizzd@aon.at>
  Subject: [Kernel-janitors] Re: [patch] MIN/MAX in ide-timing.h

min-max-linux_isicom.h.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] include/linux/isicom.h MIN/MAX removal

min-max-macintosh_macserial.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/macintosh/macserial.c MIN/MAX 	removal

min-max-tc_zs.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/tc/zs.c MIN/MAX removal

printk-net_wireless_prism54_islpci_mgt.h.patch
  From: Clemens Buchacher <drizzd@aon.at>
  Subject: [Kernel-janitors] [patch] __FUNCTION__ string concatenation

remove-check_region-char_specialix.patch
  From: Kristen Carlson <kristenc@cs.pdx.edu>
  Subject: Re: [Kernel-janitors] [PATCH] remove check_region specialix

kernel-doc_sgml.patch
  From: ""Alexey Dobriyan" " <adobriyan@mail.ru>
  Subject: [Kernel-janitors] [PATCH] Fix 'No description found for parameter' warning


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
changed since 2.6.7-kjt1

> document-cpu-sched-dir.patch
luiz asked to drop that one

> drvdata-eisa.patch
doesn't even compile

> fix-warning-af_econet.patch
was already done in networking tree.

> ipv4_fib_hash_check.patch
rejected at netdev:
fn_hash_kmem is not getting leaked,
the 'leak' seems intentional to keep using it
even if other allocations in the same routine failed.

> kernel_thread-aacraid-rkt.patch
> kernel_thread-aacraid-rx.patch
> kernel_thread-aacraid-sa.patch
merged in linus tree via James Bottomley

> printk-fix-istallion.patch
merged in linus tree via Randy, thx :)

> remove-old-ifdefs-dc390.patch
Christoph Hellwig asked to drop that,
as his patch is a superset of these changes.

> sparse-floppy98.patch
pc98 is gone, so no need for that.

> sparse-ipmi.patch
> sparse-ubd_kern.patch
done by al viro in between,
forwarded him the other sparse fixes by Alexander Nyberg



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
todo (steady backlog):
- check kernel_thread() results (Walter Harms);
        split them out
- list_for_each() usage (Domen Puncer)


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
all the patches:


extraver.patch
faulty-inits-fbmem.patch
fix-check_region-esp.patch
kernel-doc_sgml.patch
kernel_thread-i2o_core.patch
list_for_each-fs-dcache.patch
list_for_each-fs-dquot.patch
list_for_each-fs-jffs.patch
list_for_each-fs-namespace.patch
list_for_each-i386pci-common.patch
list_for_each-i386pci-pcbios.patch
list_for_each-pci-setup-bus.patch
list_for_each-pcmcia-rsrc_mgr.patch
list_for_each-ppp_generic.patch
list_for_each-sound-mem.patch
list_for_each-usb-audio.patch
list_for_each-usb-core-devices.patch
list_for_each-usb-midi.patch
min-max-char_amiserial.patch
min-max-char_epca.patch
min-max-char_esp.patch
min-max-char_isicom.patch
min-max-char_mxser.patch
min-max-char_pcmcia_synclink_cs.patch
min-max-char_pcxx.patch
min-max-char_riscom8.patch
min-max-char_rocket.patch
min-max-char_rocket_int.h.patch
min-max-char_selection.patch
min-max-char_serial167.patch
min-max-char_specialix.patch
min-max-char_synclink.patch
min-max-char_synclinkmp.patch
min-max-ide_ide-timing.h.patch
min-max-linux_isicom.h.patch
min-max-macintosh_macserial.patch
min-max-tc_zs.patch
printk-net_wireless_prism54_islpci_mgt.h.patch
remove-check_region-char_specialix.patch
remove-old-ifdefs-aic79xx.patch
remove-old-ifdefs-aic79xx_core.patch
remove-old-ifdefs-aic79xx_inline.patch
remove-old-ifdefs-aic79xx_osm.c.patch
remove-old-ifdefs-aic79xx_osm.h.patch
remove-old-ifdefs-aic79xx_osm_pci.patch
remove-old-ifdefs-aic7xxx-cam.patch
remove-old-ifdefs-aic7xxx.patch
remove-old-ifdefs-aic7xxx_core.patch
remove-old-ifdefs-aic7xxx_osm.c.patch
remove-old-ifdefs-aic7xxx_osm.h.patch
remove-old-ifdefs-aic7xxx_osm_pci.patch
remove-old-ifdefs-cpqarray.patch
remove-old-ifdefs-dmascc.patch
remove-old-ifdefs-eepro100.patch
remove-old-ifdefs-fasttimer.patch
remove-old-ifdefs-mtd-cfi.patch
remove-old-ifdefs-mtdcore.patch
static-bsd_comp.patch
static-ppp_deflate.patch
