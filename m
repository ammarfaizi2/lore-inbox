Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVDFIIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVDFIIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 04:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVDFIIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 04:08:20 -0400
Received: from 71-33-33-84.albq.qwest.net ([71.33.33.84]:35242 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261762AbVDFIII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 04:08:08 -0400
Date: Wed, 6 Apr 2005 02:10:23 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: shaun <mailinglists@unix-scripts.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic - not syncing: Fatal exception in interupt
In-Reply-To: <d2vu0u$oog$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.61.0504060209200.15520@montezuma.fsmlabs.com>
References: <d2vu0u$oog$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005, shaun wrote:

> +Hardware Specs
> Dual Xeon 800FSB
> Intel Server Board
> 4GB ECC DDR
> 3ware 9500 Sata Raid Card
> 5x200 GB sata drives in a raid 10 Config (1 hot spare)
> Dual Nic
> 
> +OS Specs
> CentOS 3.4 running a custom 2.6.x kernel patched with UML SKA's Patch
> eth0 is 0.0.0.0 promisc and assigned to a bridge (br0)
> tuntap devices up
> ebtables is enabled and loaded with rules

Is it possible to run without the bridge for testing purposes, and be 
sure to put the normal networking load?

> My problem is that every other week or so the machine crashes.  It never
> dumps the error to the logs so all i have is a screen shot of the console.
> I have put some serious stress on this machine and have been unable to
> duplicate the problem (running 20 guest UML's half running va-ctcs and the
> other half compiling a 2.6 kernel).   Below is a link to 2 screen shots i
> have (about 2 weeks apart).  I started off using a 2.6.10 kernel when the
> problem started.  Last time the machine crashed i built a 2.6.11.5 kernel
> and disabled APM and ACPI in the kernel config.  Any body know whats going
> on here.
> 
> http://www.unix-scripts.com/shaun/host-screenshot-1.png
> http://www.unix-scripts.com/shaun/host-screenshot-2.png
> 
> Kernel Config... http://www.unix-scripts.com/shaun/2.6.11.5-hr1_.config
> 
> --
> Best Regards,
> 
> Shaun Reitan
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
