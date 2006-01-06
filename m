Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbWAFSJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbWAFSJG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbWAFSJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:09:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:12190 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932388AbWAFSJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:09:04 -0500
Date: Fri, 6 Jan 2006 10:08:33 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] PCI patches for 2.6.15
Message-ID: <20060106180833.GA14235@kroah.com>
References: <20060106063716.GA4425@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106063716.GA4425@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 10:37:16PM -0800, Greg KH wrote:
> Here are some PCI patches against your latest git tree.  They have all
> been in the -mm tree for a while with no problems.
> 
> The thing that touches so many different files are the change from the
> pci_module_init() to pci_register_driver() that was done by Richard
> Knutsson.  Other big stuff is the addition of the pci error recovery
> framework, after many different revisions and reworks.
> There are also some pci hotplug fixes, and quirks added.
> 
> Please pull from:
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
> or if master.kernel.org hasn't synced up yet:
> 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
> 
> The full patches will be sent to the linux-pci mailing list, if anyone
> wants to see them.

Linus, sorry about this, but due to all of the comments and complaints
posted about this series, please do not pull it.

Thanks,

greg k-h
