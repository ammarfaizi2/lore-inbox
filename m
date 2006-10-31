Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161625AbWJaEVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161625AbWJaEVM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 23:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161481AbWJaEVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 23:21:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:62861 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161625AbWJaEVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 23:21:11 -0500
Date: Mon, 30 Oct 2006 20:20:32 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andrew.j.wade@gmail.com, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [2.6.19-rc3-mm1] BUG at arch/i386/mm/pageattr.c:165
Message-ID: <20061031042032.GA12729@kroah.com>
References: <20061029160002.29bb2ea1.akpm@osdl.org> <200610302203.37570.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20061030191340.1c7f8620.akpm@osdl.org> <200610302258.31613.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20061030201123.5685529f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030201123.5685529f.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 08:11:23PM -0800, Andrew Morton wrote:
> On Mon, 30 Oct 2006 22:58:11 -0500
> Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> 
> > I've just found out that unsetting CONFIG_SYSFS_DEPRECATED makes the
> > crash go away.
> 
> How bizarre.  sysfs changes cause unexpected pte protection values?

That's just wrong.  Something odd is happening here.  Can you try to
bisect things to determine the patch that is causing the problem?

thanks,

greg k-h
