Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751737AbWD1AB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbWD1AB4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWD1AB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:01:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:46547 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751737AbWD1ABz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:01:55 -0400
Date: Thu, 27 Apr 2006 17:00:26 -0700
From: Greg KH <greg@kroah.com>
To: Muthu Kumar <muthu.lkml@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: functions named similar (pci_acpi_init)
Message-ID: <20060428000026.GA29421@kroah.com>
References: <7da560840604271637n65106962k180234c116614d94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7da560840604271637n65106962k180234c116614d94@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 04:37:59PM -0700, Muthu Kumar wrote:
> Hi,
> While looking at something else, got drifted to looking into
> initcall<n>.init. I found two instance of pci_acpi_init() function,
> one in drivers/pci/pci-acpi.c and another in i386/pci/acpi.c.
> I understand this doesnot cause any problem since they are static, but
> someone new looking at the code could fall for it? Is it worth
> changing one of its name or should I just go away :)

If you think changing one of them would help future readers of the code,
sure, feel free to send a patch.

thanks,

greg k-h
