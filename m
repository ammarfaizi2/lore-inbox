Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUC3Pjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbUC3Pjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:39:54 -0500
Received: from mail.kroah.org ([65.200.24.183]:65232 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263733AbUC3Pid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:38:33 -0500
Date: Tue, 30 Mar 2004 07:26:29 -0800
From: Greg KH <greg@kroah.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.5-rc3
Message-ID: <20040330152629.GA22077@kroah.com>
References: <Pine.LNX.4.58.0403292129200.1096@ppc970.osdl.org> <40690B84.7060203@cornell.edu> <40690DC3.2060302@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40690DC3.2060302@cornell.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 01:03:47AM -0500, Ivan Gyurdiev wrote:
> 
> >
> >My binary-only proprietary unfree Nvidia driver is broken (and works on 
> >2.6.4). What are some interesting changeset numbers to try to locate the 
> >exact cause?
> 
> Just in case this is helpful:
> 
> Mar 29 17:23:15 cobra kernel: Badness in pci_find_subsys at 
> drivers/pci/search.c:167
> Mar 29 17:23:15 cobra kernel: Call Trace:
> Mar 29 17:23:15 cobra kernel:  [pci_find_subsys+232/240] 
> pci_find_subsys+0xe8/0xf0

known b0rkage in the nvidia driver.  been this way for months.  see the
archives for details.

thanks,

greg k-h
