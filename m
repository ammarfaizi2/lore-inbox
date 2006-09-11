Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWIKCNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWIKCNu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 22:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWIKCNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 22:13:50 -0400
Received: from ns2.osuosl.org ([140.211.166.131]:51584 "EHLO ns2.osuosl.org")
	by vger.kernel.org with ESMTP id S1750780AbWIKCNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 22:13:49 -0400
Date: Sun, 10 Sep 2006 21:14:00 -0500
From: Brandon Philips <brandon@ifup.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Brice Goglin <brice@myri.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Robert Love <rml@novell.com>
Subject: Re: 2.6.18-rc6-mm1 2.6.18-rc5-mm1 Kernel Panic on X60s
Message-ID: <20060911021400.GA6163@plankton.ifup.org>
References: <20060908174437.GA5926@plankton.ifup.org> <20060908121319.11a5dbb0.akpm@osdl.org> <20060908194300.GA5901@plankton.ifup.org> <20060908125053.c31b76e9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908125053.c31b76e9.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:50 Fri 08 Sep 2006, Andrew Morton wrote:
> On Fri, 8 Sep 2006 14:43:00 -0500
> Brandon Philips <brandon@ifup.org> wrote:
> > On 12:13 Fri 08 Sep 2006, Andrew Morton wrote:
> > > On Fri, 8 Sep 2006 12:44:37 -0500
> > > Brandon Philips <brandon@ifup.org> wrote:
> > > > 2.6.18-rc4-mm3 boots ok.
> > > > 
> > > > I will try and bisect the problem later tonight-
> > > 
> > > Thanks.  First, try disabling CONFIG_PCI_MSI.
> > 
> > With CONFIG_PCI_MSI disabled the system boots.  
> 
> OK, thanks.
> 
> So likely candidates are:
> 
> - The conversion of i386 to use the genirq code

genirq-convert-the-i386-architecture-to-irq-chips.patch is causing the
Kernel panic.

Thanks,

	Brandon

