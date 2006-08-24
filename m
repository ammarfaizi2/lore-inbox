Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWHXPBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWHXPBQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWHXPBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:01:15 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51850 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964884AbWHXPBP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:01:15 -0400
Subject: Re: Linux: Why software RAID?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc Perkel <marc@perkel.com>
Cc: Adam Kropelin <akropel1@rochester.rr.com>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux RAID Mailing List <linux-raid@vger.kernel.org>
In-Reply-To: <44EDB843.2020608@perkel.com>
References: <20060824090741.J30362@mail.kroptech.com>
	 <1156425650.3007.140.camel@localhost.localdomain>
	 <44EDB843.2020608@perkel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 16:21:32 +0100
Message-Id: <1156432892.3007.155.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-24 am 07:31 -0700, ysgrifennodd Marc Perkel:
> So - the bottom line answer to my question is that unless you are
> running raid 5 and you have a high powered raid card with cache and
> battery backup that there is no significant speed increase to use
> hardware raid. For raid 0 there is no advantage.
> 
If your raid is entirely on PCI plug in cards and you are doing RAID1
there is a speed up using hardware assisted raid because of the PCI bus
contention. If your controllers are PCI express, on internal high speed
busses (eg chipset controllers) or at least half of them are then
generally there is no win with hardware raid 0/1 and it is often slower.


