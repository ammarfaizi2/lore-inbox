Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbTJQBuR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 21:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263286AbTJQBuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 21:50:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59610 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263281AbTJQBuN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 21:50:13 -0400
Message-ID: <3F8F4AC5.7080209@pobox.com>
Date: Thu, 16 Oct 2003 21:49:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <roman@ardistech.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [ANNOUNCE] iSCSI target implementation
References: <3F8E9DA4.11ED60DA@ardistech.com>
In-Reply-To: <3F8E9DA4.11ED60DA@ardistech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Anyway, while it's in the kernel, there are also some interesting issues
> for the kernel-user space communication. Right now it's a proc only
> interface (no sysfs as it's 2.4 only, no evil ioctl, but someone will
> kill me for the macro abuse :) ), but it should be rather easy to

Adding to procfs is only slightly less "ewww" than ioctls :)  A 
dedicated chrdev would be IMO preferred to procfs.

Al Viro also had even even more interesting suggestion for [zerocopy] 
kernel/userspace communication:  ramfs.

	Jeff



