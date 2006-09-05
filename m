Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbWIEPZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbWIEPZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWIEPZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:25:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20666 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965127AbWIEPZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:25:07 -0400
Subject: Re: VIA IRQ quirk, another (embarrassing) suggestion.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: Chris Wedgwood <cw@f00f.org>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org, greg@kroah.com, harmon@ksu.edu,
       Daniel Drake <dsd@gentoo.org>, Len Brown <len.brown@intel.com>
In-Reply-To: <1157468155.30252.17.camel@localhost.localdomain>
References: <1157330567.3046.24.camel@localhost.portugal>
	 <20060903175841.7a84c63c.akpm@osdl.org> <44FBBD28.6070601@garzik.org>
	 <20060904055502.GA26816@tuatara.stupidest.org>
	 <1157370847.4624.15.camel@localhost.localdomain>
	 <20060904183352.GA14004@tuatara.stupidest.org>
	 <1157468155.30252.17.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 05 Sep 2006 16:46:06 +0100
Message-Id: <1157471166.9018.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-05 am 15:55 +0100, ysgrifennodd Sergio Monteiro Basto:
> We have billions of VIA chip sets with VIA PCI on-board and 
> VIA PCI on others chip sets, if exists, are a very few.
> So, because some exceptions, we shouldn't stop a resolution of a very
> large % of the cases. 

Not true at all. Large numbers of the VIA devices on VIA boards are not
the builtin version. Devices migrate over time from one to the other.

You can tell fron the PCI northbridge what is built in (in theory) but
we need a better way to deal with all this

