Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbUBDXqe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUBDXo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:44:27 -0500
Received: from mail.kroah.org ([65.200.24.183]:39354 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264278AbUBDXlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:41:13 -0500
Date: Wed, 4 Feb 2004 15:39:43 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PCI / OF linkage in sysfs
Message-ID: <20040204233943.GB5375@kroah.com>
References: <1075878713.992.3.camel@gaston> <Pine.LNX.4.58.0402041407160.2086@home.osdl.org> <20040204231324.GA5078@kroah.com> <1075937299.4019.41.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075937299.4019.41.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 10:28:20AM +1100, Benjamin Herrenschmidt wrote:
> 
> > Or, if you really want to be able to get the OF info from the pci device
> > in sysfs, why not create a symlink in the pci device directory pointing
> > to your OF path in sysfs?  That would seem like the best option.
> 
> The OF device-tree isn't in sysfs, it's in /proc/device-tree, we never
> "ported" that code to sysfs for various reasons.

Reasons pertaining to the sysfs interface, or other non-technical
reasons?

Even ACPI shows up in sysfs these days :)

greg k-h
