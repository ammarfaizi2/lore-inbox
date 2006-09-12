Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbWILJXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWILJXq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 05:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWILJXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 05:23:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:64662 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965160AbWILJXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 05:23:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dGIVp//j9NjJ+vHZ7R/E4AO5Njg2/3gSF2EUsmDhz2GpYGC4cHnl9JroCOendi6z028uu0BJ/F+loqjqPrPrGgvvjwn2lsIntMLkcBooYEAjGksN7f792YeaxCQJt0ayWgd/pCf0bz55M2arOHgdZbHUunA3FoqHJd6Oo/HWL0s=
Message-ID: <45067CCC.8090106@gmail.com>
Date: Tue, 12 Sep 2006 11:24:28 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc6-mm2
References: <20060912000618.a2e2afc0.akpm@osdl.org>
In-Reply-To: <20060912000618.a2e2afc0.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/
> 


This patch removes delated files from headers_install target.

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-mm/Documentation/dontdiff linux-mm-clean/include/linux/Kbuild linux-mm/include/linux/Kbuild
--- linux-mm-clean/include/linux/Kbuild	2006-09-12 11:19:46.000000000 +0200
+++ linux-mm/include/linux/Kbuild	2006-09-12 11:16:14.000000000 +0200
@@ -2,7 +2,7 @@ header-y := byteorder/ dvb/ hdlc/ isdn/
 	netfilter/ netfilter_arp/ netfilter_bridge/ netfilter_ipv4/	\
 	netfilter_ipv6/

-header-y += affs_fs.h affs_hardblocks.h aio_abi.h a.out.h arcfb.h	\
+header-y += affs_hardblocks.h aio_abi.h a.out.h arcfb.h	\
 	atmapi.h atmbr2684.h atmclip.h atm_eni.h atm_he.h		\
 	atm_idt77105.h atmioc.h atmlec.h atmmpc.h atm_nicstar.h		\
 	atmppp.h atmsap.h atmsvc.h atm_zatm.h auto_fs4.h auxvec.h	\
@@ -12,7 +12,7 @@ header-y += affs_fs.h affs_hardblocks.h
 	dqblk_v2.h dqblk_xfs.h efs_fs_sb.h elf-fdpic.h elf.h elf-em.h	\
 	fadvise.h fd.h fdreg.h ftape-header-segment.h ftape-vendors.h	\
 	fuse.h futex.h genetlink.h gen_stats.h gigaset_dev.h hdsmart.h	\
-	hpfs_fs.h hysdn_if.h i2c-dev.h i8k.h icmp.h			\
+	hysdn_if.h i2c-dev.h i8k.h icmp.h			\
 	if_arcnet.h if_arp.h if_bonding.h if_cablemodem.h if_fc.h	\
 	if_fddi.h if.h if_hippi.h if_infiniband.h if_packet.h		\
 	if_plip.h if_ppp.h if_slip.h if_strip.h if_tunnel.h in6.h	\
@@ -21,7 +21,7 @@ header-y += affs_fs.h affs_hardblocks.h
 	jffs2.h keyctl.h limits.h lock_dlm_plock.h major.h matroxfb.h	\
 	meye.h minix_fs.h mmtimer.h mqueue.h mtio.h ncp_no.h		\
 	netfilter_arp.h netrom.h nfs2.h nfs4_mount.h nfs_mount.h	\
-	openprom_fs.h param.h pci_ids.h pci_regs.h personality.h	\
+	param.h pci_ids.h pci_regs.h personality.h	\
 	pfkeyv2.h pg.h pkt_cls.h pkt_sched.h posix_types.h ppdev.h	\
 	prctl.h ps2esdi.h qic117.h qnxtypes.h quotaio_v1.h quotaio_v2.h	\
 	radeonfb.h raw.h resource.h rose.h sctp.h smbno.h snmp.h	\

