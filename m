Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTA1VuT>; Tue, 28 Jan 2003 16:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbTA1VuS>; Tue, 28 Jan 2003 16:50:18 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:57867 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261463AbTA1VuP>;
	Tue, 28 Jan 2003 16:50:15 -0500
Date: Tue, 28 Jan 2003 13:56:44 -0800
From: Greg KH <greg@kroah.com>
To: Stanley Wang <stanley.wang@linux.co.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [RFC] Get rid of all procfs stuff for PCI subsystem.
Message-ID: <20030128215644.GA7382@kroah.com>
References: <Pine.LNX.4.44.0301281747230.3171-100000@manticore.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301281747230.3171-100000@manticore.sh.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 05:59:28PM +0800, Stanley Wang wrote:
> Hi, Greg
> When did I try to remove all procfs stuff from pci_hotplug_core.c,
> I found I could only cut little codes off.

But you cut out everything that was there, right?  There wasn't much.

> So I suggest:
> How about to get rid of all procfs stuff for PCI subsystem?
> It could reduce about 700 lines codes from the kernel.
> I think we could get all information from sysfs, right?
> But it may break some user mode utilities.

If you look, a lot of it is now under a config option to just not enable
it at all, which helps out a lot.

thanks,

greg k-h
