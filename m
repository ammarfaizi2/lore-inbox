Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRCPCfq>; Thu, 15 Mar 2001 21:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbRCPCfh>; Thu, 15 Mar 2001 21:35:37 -0500
Received: from csl.Stanford.EDU ([171.64.66.149]:62647 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S129509AbRCPCfZ>;
	Thu, 15 Mar 2001 21:35:25 -0500
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200103160234.SAA03961@csl.Stanford.EDU>
Subject: [CHECKER] big stack variables
To: linux-kernel@vger.kernel.org
Date: Thu, 15 Mar 2001 18:34:33 -0800 (PST)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

enclosed are 22 functions in 2.4.1 that appear to allocate stack
variables >= 1024 bytes.  As usual, please report any false positives
so we can fix our checkers.

Dawson
-----------------------------------------------------------------------
/u2/engler/mc/2.4.1/drivers/isdn/sc/message.c:52:dump_messages: ERROR:VAR: suspicious sized variable: 'dpm' = 4112 bytes
/u2/engler/mc/2.4.1/drivers/sound/emu10k1/audio.c:906:emu10k1_audio_ioctl: ERROR:VAR: suspicious sized variable: 'buf' = 4016 bytes
/u2/engler/mc/2.4.1/drivers/i2o/i2o_proc.c:955:i2o_proc_read_drivers_stored: ERROR:VAR: suspicious sized variable: 'result' = 3596 bytes
/u2/engler/mc/2.4.1/drivers/scsi/qlogicfc.c:861:isp2x00_make_portdb: ERROR:VAR: suspicious sized variable: 'temp' = 3072 bytes
/u2/engler/mc/2.4.1/drivers/i2o/i2o_proc.c:840:i2o_proc_read_ddm_table: ERROR:VAR: suspicious sized variable: 'result' = 2828 bytes
/u2/engler/mc/2.4.1/drivers/cdrom/optcd.c:1625:cdromread: ERROR:VAR: suspicious sized variable: 'buf' = 2646 bytes
/u2/engler/mc/2.4.1/drivers/i2o/i2o_proc.c:2261:i2o_proc_read_lan_mcast_addr: ERROR:VAR: suspicious sized variable: 'result' = 2060 bytes
/u2/engler/mc/2.4.1/drivers/i2o/i2o_proc.c:2492:i2o_proc_read_lan_alt_addr: ERROR:VAR: suspicious sized variable: 'result' = 2060 bytes
/u2/engler/mc/2.4.1/drivers/i2o/i2o_proc.c:1044:i2o_proc_read_groups: ERROR:VAR: suspicious sized variable: 'result' = 2060 bytes
/u2/engler/mc/2.4.1/fs/ntfs/super.c:335:ntfs_get_free_cluster_count: ERROR:VAR: suspicious sized variable: 'bits' = 2048 bytes
/u2/engler/mc/2.4.1/drivers/atm/iphase.c:2760:ia_ioctl: ERROR:VAR: suspicious sized variable: 'regs_local' = 2048 bytes
/u2/engler/mc/2.4.1/drivers/block/cpqarray.c:1156:ida_ioctl: ERROR:VAR: suspicious sized variable: 'my_io' = 1296 bytes
/u2/engler/mc/2.4.1/net/wanrouter/wanmain.c:578:device_new_if: ERROR:VAR: suspicious sized variable: 'conf' = 1220 bytes
/u2/engler/mc/2.4.1/drivers/net/zlib.c:4216:huft_build: ERROR:VAR: suspicious sized variable: 'v' = 1152 bytes
/u2/engler/mc/2.4.1/drivers/net/zlib.c:4501:inflate_trees_fixed: ERROR:VAR: suspicious sized variable: 'c' = 1152 bytes
/u2/engler/mc/2.4.1/drivers/cdrom/cdrom.c:734:cdrom_slot_status: ERROR:VAR: suspicious sized variable: 'info' = 1032 bytes
/u2/engler/mc/2.4.1/drivers/cdrom/cdrom.c:800:cdrom_select_disc: ERROR:VAR: suspicious sized variable: 'info' = 1032 bytes
/u2/engler/mc/2.4.1/drivers/cdrom/cdrom.c:758:cdrom_number_of_slots: ERROR:VAR: suspicious sized variable: 'info' = 1032 bytes
/u2/engler/mc/2.4.1/drivers/cdrom/cdrom.c:1538:cdrom_ioctl: ERROR:VAR: suspicious sized variable: 'info' = 1032 bytes
/u2/engler/mc/2.4.1/fs/nfs/nfsroot.c:238:root_nfs_name: ERROR:VAR: suspicious sized variable: 'buf' = 1024 bytes
/u2/engler/mc/2.4.1/net/bridge/br_ioctl.c:86:br_ioctl_device: ERROR:VAR: suspicious sized variable: 'indices' = 1024 bytes
/u2/engler/mc/2.4.1/drivers/isdn/pcbit/drv.c:444:pcbit_writecmd: ERROR:VAR: suspicious sized variable: 'cbuf' = 1024 bytes
