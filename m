Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbWIJAWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWIJAWP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 20:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWIJAWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 20:22:15 -0400
Received: from mx1.suse.de ([195.135.220.2]:60138 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965055AbWIJAWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 20:22:14 -0400
Date: Sat, 9 Sep 2006 17:21:12 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Drake <dsd@gentoo.org>, akpm@osdl.org, torvalds@osdl.org,
       sergio@sergiomb.no-ip.org, jeff@garzik.org, cw@f00f.org,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org, harmon@ksu.edu,
       len.brown@intel.com, vsu@altlinux.ru, liste@jordet.net
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
Message-ID: <20060910002112.GA20672@kroah.com>
References: <20060907223313.1770B7B40A0@zog.reactivated.net> <1157811641.6877.5.camel@localhost.localdomain> <4502D35E.8020802@gentoo.org> <1157817836.6877.52.camel@localhost.localdomain> <45033370.8040005@gentoo.org> <1157848272.6877.108.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157848272.6877.108.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2006 at 01:31:12AM +0100, Alan Cox wrote:
> VIA have always told me that "ACPI handles this" and we don't need
> quirks. Various chips have different IRQ routing logic and it's all a
> bit weird if we don't use ACPI and/or BIOS routing.

So why isn't acpi handling all of this for us?  Do people not want to
use acpi for some reason?

thanks,

greg k-h
