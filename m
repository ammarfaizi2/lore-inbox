Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTI0PsL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 11:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbTI0PsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 11:48:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61177 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S262464AbTI0PsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 11:48:08 -0400
Date: Sat, 27 Sep 2003 11:47:00 -0400
From: Jean-Marc Spaggiari <Jean-Marc@Spaggiari.org>
Subject: Re: Kernel panic:Unable to mount root fs (2.6.0-test5)
In-reply-to: <20030927145149.65265.qmail@web40904.mail.yahoo.com>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3F75B0F4.3040407@Spaggiari.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: fr-fr, fr-ca, fr-be, fr-lu, fr-mc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
References: <20030927145149.65265.qmail@web40904.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I will be hapy if I can help in any kind, so, at this time, i'm going back to
>>2.4.22. (Need I to poste my .config here ?)
> 
> 
> Please do so. Specifically, post the part of your .config which shows how your
> filesystems are configured. It looks to me like you may have accidentally compiled
> ext3 as a module; if your / filesystem is ext3, it must be compiled into the kernel
> in order for the kernel to mount your root filesystem and run /sbin/init.
>
> Brad Chapman
> 
> Permanent e-mail: kakadu_croc@yahoo.com

I htink I have activated all that's possible in my Kernel :

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y

If you have any suggestion, I can try immediatly an send you feedback 
fastly.

Thanks,

JMS.

