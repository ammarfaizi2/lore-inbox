Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTI0QYq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 12:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbTI0QYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 12:24:46 -0400
Received: from web40912.mail.yahoo.com ([66.218.78.209]:58261 "HELO
	web40912.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262493AbTI0QYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 12:24:44 -0400
Message-ID: <20030927162443.68906.qmail@web40912.mail.yahoo.com>
Date: Sat, 27 Sep 2003 09:24:43 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: Kernel panic:Unable to mount root fs (2.6.0-test5)
To: Jean-Marc Spaggiari <Jean-Marc@Spaggiari.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F75B0F4.3040407@Spaggiari.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Spaggari,

--- Jean-Marc Spaggiari <Jean-Marc@Spaggiari.org> wrote:
> >>I will be hapy if I can help in any kind, so, at this time, i'm going back to
> >>2.4.22. (Need I to poste my .config here ?)
> > 
> > 
> > Please do so. Specifically, post the part of your .config which shows how your
> > filesystems are configured. It looks to me like you may have accidentally
> compiled
> > ext3 as a module; if your / filesystem is ext3, it must be compiled into the
> kernel
> > in order for the kernel to mount your root filesystem and run /sbin/init.
> >
> > Brad Chapman
> > 
> > Permanent e-mail: kakadu_croc@yahoo.com
> 
> I htink I have activated all that's possible in my Kernel :
> 
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> CONFIG_EXT2_FS_SECURITY=y
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> CONFIG_EXT3_FS_SECURITY=y
> CONFIG_JBD=y
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> CONFIG_FS_POSIX_ACL=y
> # CONFIG_XFS_FS is not set
> CONFIG_MINIX_FS=m
> # CONFIG_ROMFS_FS is not set
> CONFIG_QUOTA=y
> # CONFIG_QFMT_V1 is not set
> # CONFIG_QFMT_V2 is not set
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS_FS=y
> CONFIG_AUTOFS4_FS=y
> 
> If you have any suggestion, I can try immediatly an send you feedback 
> fastly.

Can you send more of the dmesg that comes from 2.6 when you try to boot it?
(i.e. send more lines of it than the last few)

> 
> Thanks,
> 
> JMS.
> 

Brad


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
