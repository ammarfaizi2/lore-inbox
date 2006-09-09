Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWIIPlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWIIPlu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 11:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWIIPlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 11:41:50 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60035 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932273AbWIIPlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 11:41:50 -0400
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: akpm@osdl.org, torvalds@osdl.org, sergio@sergiomb.no-ip.org,
       jeff@garzik.org, greg@kroah.com, cw@f00f.org, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru, liste@jordet.net
In-Reply-To: <4502D35E.8020802@gentoo.org>
References: <20060907223313.1770B7B40A0@zog.reactivated.net>
	 <1157811641.6877.5.camel@localhost.localdomain>
	 <4502D35E.8020802@gentoo.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Sep 2006 17:03:55 +0100
Message-Id: <1157817836.6877.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-09 am 10:44 -0400, ysgrifennodd Daniel Drake:
> Alan Cox wrote:
> > Very large numbers of VIA mainboards ship with some of the VIA devices
> > built in and some of them on the PCI bus. 
> 
> What's the difference between "built in" and "on the PCI bus"? Both 
> types are physically a part of the mainboard, and need to be quirked, right?

No.

If they are on the V-Bus then the IRQ number controls routing if they
are on the PCI bus the IRQ line controls routing as normal.


