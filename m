Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268848AbUHLWnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268848AbUHLWnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268847AbUHLWnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:43:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:16519 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268848AbUHLWlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:41:20 -0400
Date: Thu, 12 Aug 2004 15:31:12 -0700
From: Greg KH <greg@kroah.com>
To: John Riggs <jriggs@altiris.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.7 Linux Kernel Crash While Detecting PCI Devices
Message-ID: <20040812223112.GA3408@kroah.com>
References: <9B96255DE3B181429D06C6ADB0B37470232B29@sandman.altiris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9B96255DE3B181429D06C6ADB0B37470232B29@sandman.altiris.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 11:47:16AM -0600, John Riggs wrote:
> > Yes, that sounds like what is happening.  Can you build a modular
> kernel
> > and load the drivers you need one by one until the error happens?
> 
> After rebuilding the modular kernel I see that the crash happens before
> any modules are loaded.

Ick.  I really don't know what's happening here.  You obviously have
some pci drivers build into the kernel.  Which ones?

thanks,

greg k-h
