Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269555AbTGXRUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 13:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269557AbTGXRUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 13:20:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:10649 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269555AbTGXRU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 13:20:26 -0400
Date: Thu, 24 Jul 2003 13:35:26 -0400
From: Greg KH <greg@kroah.com>
To: Douglas J Hunley <doug@hunley.homeip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: Badness in pci_find_subsys!!
Message-ID: <20030724173526.GA7952@kroah.com>
References: <200307241326.04656.doug@hunley.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307241326.04656.doug@hunley.homeip.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 01:26:01PM -0400, Douglas J Hunley wrote:
> Just had my athlon box lock-up solid. needed SysRq to reboot the thing.. 
> kernel info follows:
> Jul 24 13:08:23 doug kernel: Badness in pci_find_subsys at 
> drivers/pci/search.c:132
> Jul 24 13:08:23 doug kernel: Call Trace:
> Jul 24 13:08:23 doug kernel:  [<c02064a1>] pci_find_subsys+0x111/0x120
> Jul 24 13:08:23 doug kernel:  [<c02064df>] pci_find_device+0x2f/0x40
> Jul 24 13:08:23 doug kernel:  [<c0206368>] pci_find_slot+0x28/0x50
> Jul 24 13:08:23 doug kernel:  [<f8a2ada4>] os_pci_init_handle+0x3a/0x67 
> [nvidia]

You are using the nvidia driver.  Go complain to them as we can do
nothing about their code, sorry.

greg k-h
