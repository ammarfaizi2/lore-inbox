Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbWKBUdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWKBUdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 15:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbWKBUdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 15:33:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:21607 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751601AbWKBUdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 15:33:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FPfH5qTeqm6wbGQwVPgeOdXzgMYPNqbf5aMtKVl6xOQaR39um7SkHY7XnAOQPzFOj2PU94o0jeox2Ligva8Z9l4A/9O08derSYtzkQhwhB/Kcc3cGaBuexKDERe/fmYy2DJh1lDiJCZFqNoL/j0VN60Uyt0F6D1XqVu/+SUq4Bg=
Message-ID: <a44ae5cd0611021233l4324e3b0k4a27c66fc9003d86@mail.gmail.com>
Date: Thu, 2 Nov 2006 12:33:31 -0800
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.19-rc4-mm2 -- Build problems
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: drivers/char/hw_random/intel-rng.o - Section mismatch:
reference to .init.text: from .parainstructions after '' (at offset
0x0)
WARNING: drivers/char/hw_random/intel-rng.o - Section mismatch:
reference to .init.text: from .parainstructions after '' (at offset
0x8)
WARNING: drivers/char/hw_random/intel-rng.o - Section mismatch:
reference to .init.text: from .parainstructions after '' (at offset
0x10)
WARNING: "ata_sas_slave_configure" [drivers/scsi/libsas/libsas.ko] undefined!
WARNING: "ata_port_disable" [drivers/scsi/libsas/libsas.ko] undefined!
WARNING: "ata_sas_port_init" [drivers/scsi/libsas/libsas.ko] undefined!
WARNING: "ata_sas_port_stop" [drivers/scsi/libsas/libsas.ko] undefined!
WARNING: "ata_sas_port_start" [drivers/scsi/libsas/libsas.ko] undefined!
WARNING: "ata_sas_port_alloc" [drivers/scsi/libsas/libsas.ko] undefined!
WARNING: "ata_noop_qc_prep" [drivers/scsi/libsas/libsas.ko] undefined!
WARNING: "ata_tf_to_fis" [drivers/scsi/libsas/libsas.ko] undefined!
WARNING: "ata_noop_dev_select" [drivers/scsi/libsas/libsas.ko] undefined!
WARNING: "ata_tf_from_fis" [drivers/scsi/libsas/libsas.ko] undefined!
WARNING: "ata_host_init" [drivers/scsi/libsas/libsas.ko] undefined!
WARNING: "ata_sas_queuecmd" [drivers/scsi/libsas/libsas.ko] undefined!
WARNING: "ata_sas_port_destroy" [drivers/scsi/libsas/libsas.ko] undefined!
WARNING: "ata_scsi_ioctl" [drivers/scsi/libsas/libsas.ko] undefined!
WARNING: "ata_qc_complete" [drivers/scsi/libsas/libsas.ko] undefined!

#
# SCSI device support
#
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=m
# CONFIG_SCSI_TGT is not set
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_LIBSAS_DEBUG=y
