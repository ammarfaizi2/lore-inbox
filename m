Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbTDHUWf (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 16:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbTDHUWf (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 16:22:35 -0400
Received: from rj.SGI.COM ([192.82.208.96]:24970 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261727AbTDHUWe (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 16:22:34 -0400
Date: Tue, 8 Apr 2003 13:34:10 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2/3] PCI sysfs improvements
Message-ID: <20030408203410.GA18765@sgi.com>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	linux-kernel@vger.kernel.org
References: <20030407234334.GS23430@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030407234334.GS23430@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 12:43:34AM +0100, Matthew Wilcox wrote:
> 
> [Note: This patch depends on the sysfs-bin patch]
> 
> Improve pci-sysfs:
>  - Add PCI config space access to sysfs.
>  - Prefix values in the PCI space with `0x' cos they're hex values.
>  - Reformat the resource file with 64-bit values.
>  - Present all resources in the file, don't stop at the first empty one.
> 
> Todo:
>  - Implement write access.
>  - Convert resource file into directories

This looks good.  Could you post what the relevant sysfs tree looks
like?  I like your idea of adding mmio and portio space as well.  And
of course, I'd like legacy I/O space too, but I guess I'll have to do
that myself if I find the time...

Thanks,
Jesse
