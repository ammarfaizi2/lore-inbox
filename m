Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751770AbWHNBRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbWHNBRX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 21:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWHNBRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 21:17:23 -0400
Received: from smtp19.orange.fr ([80.12.242.1]:28553 "EHLO
	smtp-msa-out19.orange.fr") by vger.kernel.org with ESMTP
	id S1751770AbWHNBRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 21:17:22 -0400
X-ME-UUID: 20060814011721691.A8B731C00081@mwinf1919.orange.fr
Message-ID: <44DFCF20.9030202@wanadoo.fr>
Date: Mon, 14 Aug 2006 03:17:20 +0200
From: Hulin Thibaud <hulin.thibaud@wanadoo.fr>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel panic - not syncing: VFS - unable to mount root fs on unknown-block
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !
I'm trying to compile my own kernel for drivers on two computers, but 
that fails. A the boot, I have this error :
kernel panic - not syncing: VFS Unable to mount root fs on unknow-block 
(3.69)

I'm using the kernel 2.6.19 with Ubuntu Dapper. I use the old boot 
config and I type make oldconfig, so I don't understand why there are an 
error with the near same configuration.
I suppose that I must compile not in module but in hard support for my 
IDE chipset, harddisk and file system. Probably, I don't understand how 
do exactly. I do that :
lspci |grep IDE
0000:00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
make xconfig
-Device Drivers
--* ATA/ATAPI/MFM/RLL support
--- * Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support
--- * Include IDE/ATA-2 DISK support
--- * PCI IDE chipset support
---- * Generic PCI IDE Support
----- * VIA82CXXX chipset support
- File systems
-- * Ext3 journalling file system support
--- * Ext3 extended attributes
---- * Ext3 POSIX Access Control Lists
---- * Ext3 Security Labels

Have I forgot anything ?

Thanks very much,
Thibaud.
