Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269607AbUI3W76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269607AbUI3W76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269612AbUI3W76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:59:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:55529 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269607AbUI3W72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:59:28 -0400
Date: Thu, 30 Sep 2004 16:03:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: kaneshige.kenji@jp.fujitsu.com, greg@kroah.com, ashok.raj@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add hook for PCI resource deallocation
Message-Id: <20040930160318.3cebcb89.akpm@osdl.org>
In-Reply-To: <20040930152117.A30196@unix-os.sc.intel.com>
References: <41498CF6.9000808@jp.fujitsu.com>
	<20040924130251.A26271@unix-os.sc.intel.com>
	<20040924212208.GD7619@kroah.com>
	<4157CA04.5050604@jp.fujitsu.com>
	<20040930145014.71e04b25.akpm@osdl.org>
	<20040930152117.A30196@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> On Thu, Sep 30, 2004 at 02:50:14PM -0700, Andrew Morton wrote:
> > Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:
> > >
> > > I'm attaching updated patches for adding pcibiod_disable_device()
> > > hook based on the feedback from Ashok (Thank you, Ashok!).
> > 
> > This appears to be a patch-reversed version of the patch which is already
> > in -mm:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm4/broken-out/add-hook-for-pci-resource-deallocation.patch
> > 
> > So I'm not sure what you're trying to do here.
> 
> 
> In the original patch, Kenji added a dummy function in several source files. Instead now
> the new patch should have a single default implementation with a __attribute__((weak))
> 
> As a result its removing all the old additions and now keeping just a single default function.

Oh.  You may as well send a (chagelogged, signed off) new patch against
current -linus in that case.
