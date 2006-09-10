Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965245AbWIJEiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbWIJEiR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 00:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965249AbWIJEiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 00:38:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:44715 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965245AbWIJEiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 00:38:17 -0400
Date: Sat, 9 Sep 2006 21:37:41 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Drake <dsd@gentoo.org>,
       akpm@osdl.org, torvalds@osdl.org, sergio@sergiomb.no-ip.org,
       jeff@garzik.org, bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       harmon@ksu.edu, len.brown@intel.com, vsu@altlinux.ru, liste@jordet.net
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
Message-ID: <20060910043741.GA21327@kroah.com>
References: <20060907223313.1770B7B40A0@zog.reactivated.net> <1157811641.6877.5.camel@localhost.localdomain> <4502D35E.8020802@gentoo.org> <1157817836.6877.52.camel@localhost.localdomain> <45033370.8040005@gentoo.org> <1157848272.6877.108.camel@localhost.localdomain> <20060910002112.GA20672@kroah.com> <20060910003922.GA8147@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910003922.GA8147@tuatara.stupidest.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 05:39:22PM -0700, Chris Wedgwood wrote:
> On Sat, Sep 09, 2006 at 05:21:12PM -0700, Greg KH wrote:
> 
> > So why isn't acpi handling all of this for us?
> 
> for some people it does...
> 
> > Do people not want to use acpi for some reason?
> 
> I was told that in the past VIA has buggy/broken ACPI, so we need to
> figure out what ACPI workaround Windows has and implement that (or
> maybe they do it in the driver(s)?)

Then that sounds like an ACPI issue, instead of trying to create a quirk
for the pci device itself.

Why not enable ACPI (which the manufacturer says is the way to go), and
then work from there?

thanks,

greg k-h
