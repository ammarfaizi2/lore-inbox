Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751881AbWICBug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbWICBug (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 21:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbWICBug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 21:50:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20892 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751881AbWICBuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 21:50:35 -0400
Date: Sat, 2 Sep 2006 18:50:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No RAID/LVM config in 2.6.18-rc5-mm1
Message-Id: <20060902185027.adaeea48.akpm@osdl.org>
In-Reply-To: <44FA28F7.8010001@bellsouth.net>
References: <44FA28F7.8010001@bellsouth.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Sep 2006 19:59:35 -0500
Jay Cliburn <jacliburn@bellsouth.net> wrote:

> I'm trying to build 2.6.18-rc5-mm1 from scratch, but I can't find the 
> config options for multi-device (RAID and LVM).  If I go ahead and build 
> a kernel without those options, it fails to boot, complaining that 
> dm-snapshot and others are missing.
> 
> Here is the sequence of events:
> 1.  Untar linux-2.6.17.tar.gz
> 	make menuconfig -- Yep, multi-device options are there.
> 2.  Apply patch-2.6.18-rc5
> 	make menuconfig -- Yep, again, multi-device options are there.
> 3.  Apply patch 2.6.18-rc5-mm1
> 	make menuconfig -- multi-device options are gone.
> 

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/hot-fixes/
contains a fix for this.


-- 
VGER BF report: U 0.472843
