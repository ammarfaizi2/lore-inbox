Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264494AbTFEHmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 03:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTFEHmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 03:42:18 -0400
Received: from pan.togami.com ([66.139.75.105]:39836 "EHLO pan.mplug.org")
	by vger.kernel.org with ESMTP id S264494AbTFEHmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 03:42:17 -0400
Subject: 2.4.21-rc7 AMD64 dpt_i2o fails compile
From: Warren Togami <warren@togami.com>
To: amd64-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030605010841.A29837@devserv.devel.redhat.com>
References: <1054789161.3699.67.camel@laptop>
	 <20030605010841.A29837@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1054799692.3699.77.camel@laptop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (1.3.92-1) (Preview Release)
Date: 04 Jun 2003 21:54:53 -1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-04 at 19:08, Bill Nottingham wrote:
> Warren Togami (warren@togami.com) said: 
> > My two Tyan S2880GNR dual Opteron servers came in today.  Sweet!
> > 
> > Unfortunately the Adaptec 2110S SCSI RAID controllers within both
> > servers are unable to work with any of the drivers in GinGin64's
> > Anaconda.  Searching the net it seems that this controller needs the
> > dpt_i2o module which exists in Shrike, but not in GinGin64's kernel. 
> > Were there problems with that module in AMD64?
> > 
> > http://www.togami.com/~warren/archive/2003/tyan_opteron.txt
> > lspci, lspci -n, lspci -vvv
> > 
> > I'm installing onto an IDE hard drive now and plan on building custom
> > kernels from there.
> > 
> > Any recommendations of things to try?
> 
> Rebuild the kernel with the driver, see what happens. I don't think
> we've tested that driver here to confirm whether it does or doesn't
> have problems.
> 

http://www.togami.com/~warren/archive/2003/dpt_failure.txt
2.4.20-9.2 (GinGin64)
Build failure when dpt is enabled as a module.  This is probably why
this and many other kernel modules were not included in the GinGin64
preview release.

Unfortunately it fails compilation in the same place for 2.4.21-rc7. 
I'm testing 2.5.70-bk* next.

LKML, any existing patches for this dpt_i2o module AMD64 compilation
issue?  Please CC me because not currently subscribed to lkml.

Thanks,
Warren Togami
warren@togami.com

