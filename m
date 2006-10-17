Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWJQMd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWJQMd5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 08:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWJQMd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 08:33:57 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:32929 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750797AbWJQMd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 08:33:56 -0400
Subject: Re: config EXT4DEV_FS question
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Mingming Cao <cmm@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Randy Dunlap <rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0610170100480.30479@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610170100480.30479@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 07:33:50 -0500
Message-Id: <1161088430.14171.2.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-17 at 01:08 +0200, Jan Engelhardt wrote:
> Hi,
> 
> 
> 
> something I have seen during `make oldconfig`, in fs/Kconfig we find:
> 
> config EXT4DEV_FS
>    ...
> 
>   To compile this file system support as a module, choose M here. The
>   module will be called ext4dev.  Be aware, however, that the
>   filesystem of your root partition (the one containing the directory
>   /) cannot be compiled as a module, and so this could be dangerous.
> 
> 
> Why can't this be compiled as a module when / is ext4? There are a lot
> of people out there having no filesystem code included in the kernel at
> all (includes at least SUSE users using the default vendor kernel), but
> instead have them as modules in their initramfss (what's the proper
> plural of initramfs?). What is it that makes ext4 different?

That same paragraph is in the help text of both ext2 and ext3.  It is a
bit outdated and should probably be cleaned up in all three.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

