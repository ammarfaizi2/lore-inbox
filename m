Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWGGQbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWGGQbu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 12:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWGGQbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 12:31:50 -0400
Received: from xenotime.net ([66.160.160.81]:21132 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932202AbWGGQbt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 12:31:49 -0400
Date: Fri, 7 Jul 2006 09:34:32 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jamagallon@ono.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-Id: <20060707093432.571af16e.rdunlap@xenotime.net>
In-Reply-To: <1152290643.20883.25.camel@localhost.localdomain>
References: <20060703030355.420c7155.akpm@osdl.org>
	<20060705234347.47ef2600@werewolf.auna.net>
	<20060705155602.6e0b4dce.akpm@osdl.org>
	<20060706015706.37acb9af@werewolf.auna.net>
	<20060705170228.9e595851.akpm@osdl.org>
	<20060706163646.735f419f@werewolf.auna.net>
	<20060706164802.6085d203@werewolf.auna.net>
	<20060706234425.678cbc2f@werewolf.auna.net>
	<20060706145752.64ceddd0.akpm@osdl.org>
	<1152288168.20883.8.camel@localhost.localdomain>
	<20060707175509.14ea9187@werewolf.auna.net>
	<1152290643.20883.25.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jul 2006 17:44:03 +0100 Alan Cox wrote:

> Ar Gwe, 2006-07-07 am 17:55 +0200, ysgrifennodd J.A. Magallón:
> > I think it is enough to change the detection order, first real SATA and then
> > PATA, so the only drives that change names are the PATA ones.
> > (it that's easy enough...)
> 
> The order is determined by the PCI layer code, and of course by what
> order you load the modules. Rigidly defined certainities about driver
> ordering went out with hotplug. 

For built-in drivers, the link order matters.
The the libata PATA drivers are sort of "randomly" mixed in
with the SATA drivers.

> > Mmm, I have thought on another thing. RAID devices do not store the /dev
> > node of pieces on the superblock, just drive IDs, isn't it ?
> 
> RAID just works and LVM. I flip Fedora boxes between drivers on a
> regular basis without a glitch.


---
~Randy
