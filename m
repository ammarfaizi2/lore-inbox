Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266963AbUBGQU4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 11:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266964AbUBGQU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 11:20:56 -0500
Received: from ns.suse.de ([195.135.220.2]:64973 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266963AbUBGQUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 11:20:55 -0500
Date: Sat, 7 Feb 2004 17:20:54 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.3 CONFIG_SCSI_AIC7 X X X Kconfig bug
Message-ID: <20040207162054.GA25651@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


who made that 'XXX in subject' reject? That is bug one.

another bug:

scsi is a module, but aic7xxx doesnt get build because it is set to yes.
plain 2.6.3-rc1, happend also with 2.6.2.

grep SCSI .config | grep =
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_SCSI=m
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_SCSI_QLA2XXX_CONFIG=m
CONFIG_SCSI_DEBUG=m
CONFIG_USB_HPUSBSCSI=m

I can not set CONFIG_SCSI_DEBUG to y, this is handled correctly.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
