Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWFWB77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWFWB77 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 21:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWFWB77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 21:59:59 -0400
Received: from xenotime.net ([66.160.160.81]:24300 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750700AbWFWB76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 21:59:58 -0400
Date: Thu, 22 Jun 2006 19:02:43 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: sergio@sergiomb.no-ip.org
Cc: cw@f00f.org, kernel@agotnes.com, akpm@osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu,
       vsu@altlinux.ru
Subject: Re: how I know if a interrupt is ioapic_edge_type or
 ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:
 2.6.17-rc6-mm2 - USB issues]]
Message-Id: <20060622190243.0cd02f82.rdunlap@xenotime.net>
In-Reply-To: <1151027415.2835.5.camel@localhost.portugal>
References: <4497DA3F.80302@agotnes.com>
	<20060620044003.4287426d.akpm@osdl.org>
	<4499245C.8040207@agotnes.com>
	<1150936606.2855.21.camel@localhost.portugal>
	<20060621174754.159bb1d0.rdunlap@xenotime.net>
	<1150938288.3221.2.camel@localhost.portugal>
	<20060621210817.74b6b2bc.rdunlap@xenotime.net>
	<1150977386.2859.34.camel@localhost.localdomain>
	<20060622142902.5c8f8e67.rdunlap@xenotime.net>
	<1151016398.3022.4.camel@localhost.portugal>
	<20060622225405.GA5840@tuatara.stupidest.org>
	<1151024444.2858.14.camel@localhost.portugal>
	<20060622183926.fada1a25.rdunlap@xenotime.net>
	<1151027415.2835.5.camel@localhost.portugal>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 02:50:15 +0100 Sergio Monteiro Basto wrote:

> On Thu, 2006-06-22 at 18:39 -0700, Randy.Dunlap wrote:
> > This sounds like just running with CONFIG_IO_APIC=n or using
> > "noapic" on the kernel boot command line.  If that's what is
> > needed, we can know that.  I just haven't seen info to know
> > what the real problem is. 
> 
> yes, could be a way, if we know if IO_APIC or LOCAL_APIC is enabled or
> not ?

I don't know of a current flag or state that tells us that,
but it could be added.

---
~Randy
