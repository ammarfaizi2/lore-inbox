Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264835AbUEKRMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264835AbUEKRMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264909AbUEKRKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 13:10:47 -0400
Received: from fmr10.intel.com ([192.55.52.30]:31873 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S264835AbUEKRJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 13:09:33 -0400
Subject: Re: new laptop woes
From: Len Brown <len.brown@intel.com>
To: jnf <jnf@datakill.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FB0B1@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FB0B1@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1084295342.12359.116.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 May 2004 13:09:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 12:24, jnf wrote:

> 2) ACPI support.
> ouch. this laptop being a hp pavilion ze4430us, it seems to have
> 'issues' 
> with acpi [I googled around some and found others speaking of the 
> problems, but it doesnt look like anyone found a fix]- what i get
> whenever 
> i attempt to enable acpi in the kernel [this is true under 
> 2.4.20/2.4.26/2.6.5] is that:
> 1] i have to turn off the framebuffer device [id assume this is
> because it 
> gets handled after acpi]
> 2] it hangs with the message:
> 'ACPI: IRQ 9 SCI: Level Trigger'
> 

try booting with "nolapic"

> When I googled around, as I said, I found several people with this
> problem 
> and related issues, but no fixes- one interesting thing to me was that
> *all* of the related things on google i could find had that exact
> message, 
> i.e. IRQ 9.
> I went to take a look at the ACPI page [acpi.sourforge...] and looking
> through their cvs tree it looks like most of it hasnt been touched in 
> aprox 12 months or more? 

I escaped from CVS in 1994, underwent several years of therapy, and
haven't used it since.  I don't know what ACPI CVS is on SF, point me to
it and I'll be happy to delete it.

The latest ACPI is published here:

http://linux-acpi.bkbits.net/
and here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/

though these are generally never more than 10 days newer than
the latest 2.4, 2.6, and 2.6-mm trees.

cheers,
-Len


