Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWFXCrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWFXCrj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 22:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933196AbWFXCrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 22:47:39 -0400
Received: from ns2.suse.de ([195.135.220.15]:52657 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932072AbWFXCri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 22:47:38 -0400
Date: Fri, 23 Jun 2006 19:44:12 -0700
From: Greg KH <greg@kroah.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix "Trying to free nonexistent resource" format string
Message-ID: <20060624024412.GA29637@kroah.com>
References: <20060621175700.GA4620@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621175700.GA4620@hexapodia.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 10:57:00AM -0700, Andy Isaacson wrote:
> In 2.6.17-mm1, the patch
> gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-arch-and-core-code.patch
> has some formatting bugs.
>  * converts %08x into %16llx, which results in space-padding rather than
>    zero-padding.
>  * some casts are insufficiently touchy-feely with their castees.
> 
> This patch fixes them.
> 
> Signed-off-by: Andy Isaacson <adi@hexapodia.org>

Thanks, I've merged this in with the original patch and added your
Signed-off-by to it.

thanks,

greg k-h
