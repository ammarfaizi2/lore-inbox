Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422805AbWA1C0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422805AbWA1C0U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422801AbWA1C0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:26:00 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:38575
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1422800AbWA1CZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:25:52 -0500
Date: Fri, 27 Jan 2006 18:25:54 -0800
From: Greg KH <greg@kroah.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.12.6-xen] sysfs attributes for xen
Message-ID: <20060128022554.GA20766@kroah.com>
References: <43DAD4DB.4090708@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DAD4DB.4090708@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 09:20:11PM -0500, Mike D. Day wrote:
> Creates /sys/hypervisor/xen and populates that dir with xen version, 
> changeset, compilation, and capabilities info. Intended for the xen merge 
> tree and later upstream. 
> # HG changeset patch
> # User mdday@dual.silverwood.home
> # Node ID 9a9f2a5f087c97186bd43561b90f30510413a3e2
> # Parent  2e82fd7a69212955b75c6adaed4ae2a58ae45399
> add /sys/hypervisor/xen to sysfs and populate with xen version attributes. 
> 
> signed-off-by: Mike D. Day <ncmike@us.ibmcom>

"Signed-off-by:" please.

Also, a valid email address is required here.

> 
> diff -r 2e82fd7a6921 -r 9a9f2a5f087c 
> linux-2.6-xen-sparse/arch/xen/kernel/Makefile
> --- a/linux-2.6-xen-sparse/arch/xen/kernel/Makefile	Fri Jan 27 11:48:32 
> 2006
> +++ b/linux-2.6-xen-sparse/arch/xen/kernel/Makefile	Fri Jan 27 14:28:42 
> 2006

The patch is linewrapped, and all leading spaces were eaten by someone
for dinner.

Please try resending it in a format that can be applied.

thanks,

greg k-h
