Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVDBEFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVDBEFH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 23:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbVDBEFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 23:05:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:56755 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261679AbVDBEFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 23:05:04 -0500
Date: Fri, 1 Apr 2005 20:04:49 -0800
From: Greg KH <gregkh@suse.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, prarit@sgi.com
Subject: Re: PCI: fix an oops in some pci devices on hotplug remove when their resources are being freed.
Message-ID: <20050402040448.GA16943@kroah.com>
References: <11123992702166@kroah.com> <11123992703458@kroah.com> <20050402011023.GG21986@parcelfarce.linux.theplanet.co.uk> <20050402033141.GA16556@kroah.com> <20050402035330.GH21986@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050402035330.GH21986@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2005 at 04:53:30AM +0100, Matthew Wilcox wrote:
> 
> So yes, please revert this patch.  There is no way it can possibly
> affect anything.

Agreed.  It's now reverted and is queued for Linus to pull from.

Thanks for reviewing this.

greg k-h
