Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263790AbUFCThN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263790AbUFCThN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 15:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbUFCThN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 15:37:13 -0400
Received: from mail.kroah.org ([65.200.24.183]:41617 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263790AbUFCTgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 15:36:36 -0400
Date: Thu, 3 Jun 2004 12:32:56 -0700
From: Greg KH <greg@kroah.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.6-rc2 RFT] Add's class support to cpuid.c
Message-ID: <20040603193256.GD23564@kroah.com>
References: <98460000.1086215543@dyn318071bld.beaverton.ibm.com> <40BE6CA9.9030403@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BE6CA9.9030403@zytor.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 05:11:21PM -0700, H. Peter Anvin wrote:
> Hanna Linder wrote:
> >This patch adds class support to arch/i386/kernel/cpuid.c. This enables 
> >udev
> >support. I have tested on a 2-way SMP system and on a 2-way built as UP.
> >Here are the results for the SMP:
> 
> I think it would be better if udev could handle /dev/cpu as an iterator 
> instead of needing O(N) kernel memory for all per-CPU devices; I made the 
> same comments about devfs.

Sorry, but that's not going to happen at this time.

> As it is, it also mishandles the hotswap CPU scenario.

I agree, but that can be easily added with a second patch on top of this
one, right Hanna?  :)

I'll go add this to the driver-2.6 bk tree to show up in the next -mm.

thanks,

greg k-h
