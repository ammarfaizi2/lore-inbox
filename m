Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbVJUA4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVJUA4f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 20:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVJUA4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 20:56:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:6097 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964835AbVJUA4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 20:56:35 -0400
Date: Thu, 20 Oct 2005 17:31:53 -0700
From: Greg KH <greg@kroah.com>
To: David Daney <ddaney@avtrex.com>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: Patch: ATI Xilleon port 4/11 Xilleon PCI IDs
Message-ID: <20051021003152.GC18404@kroah.com>
References: <17239.13300.410843.465349@dl2.hq2.avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17239.13300.410843.465349@dl2.hq2.avtrex.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2005 at 11:06:44PM -0700, David Daney wrote:
> This is the fourth part of my Xilleon port.
> 
> I am sending the full set of patches to linux-mips@linux-mips.org
> which is archived at: http://www.linux-mips.org/archives/
> 
> Only the patches that touch generic parts of the kernel are coming
> here.
> 
> This patch adds some PCI ids for ATI's Xilleon family of SOCs.

Does your driver need all of these ids?  If not, please only include the
ones needed, we are removing all of the unused ids, as we don't need to
keep a file with all possible pci ids in the kernel tree.

thanks,

greg k-h
