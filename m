Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270857AbTHAR7T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 13:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270865AbTHAR7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 13:59:19 -0400
Received: from bay7-f16.bay7.hotmail.com ([64.4.11.16]:13836 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S270869AbTHAR7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 13:59:10 -0400
X-Originating-IP: [62.98.206.48]
X-Originating-Email: [kernel_286@hotmail.com]
From: "jorge kernel" <kernel_286@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: VFS: Cannot open root device "304" or hda4
Date: Fri, 01 Aug 2003 19:59:09 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <BAY7-F16IsQN3CQ49Li0001c8e1@hotmail.com>
X-OriginalArrivalTime: 01 Aug 2003 17:59:10.0061 (UTC) FILETIME=[9BC979D0:01C35856]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Cédric Barboiron <ced2ml@ifrance.com>
>To: kernel_286@hotmail.com
>Subject: Re: VFS: Cannot open root device "304" or hda4
>Date: Fri, 01 Aug 2003 17:27:12 +0200

Hi  Cédric,

[cut]
>Did you enable correct Partition Type Support ?

I think the config file is OK because I've only set the partition types I 
need and I always used (My root fs is ext3):

CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y   <-------
CONFIG_EXT3_FS_XATTR=y   <-------
CONFIG_EXT3_FS_POSIX_ACL=y   <-------
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y    <-------
CONFIG_JBD_DEBUG=y   <------
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

I've even tried using initrd, but when 2.6 start, I see that it can't load 
any initrd image: unfortunatly I've create it with 'mkinitrd -o 
/boot/initrd-2.6-t2 /lib/modules/linux-2.6-test2'...

									Mario

_________________________________________________________________
Nuovo MSN Messenger 6.0 con sfondi e giochi! http://messenger.msn.it/ 
Provalo subito!

