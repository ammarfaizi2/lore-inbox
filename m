Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284882AbRLKDms>; Mon, 10 Dec 2001 22:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284871AbRLKDmi>; Mon, 10 Dec 2001 22:42:38 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:33800 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S284882AbRLKDm1>; Mon, 10 Dec 2001 22:42:27 -0500
Date: Mon, 10 Dec 2001 22:42:27 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200112110342.fBB3gQe19601@devserv.devel.redhat.com>
To: jomast@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: USB + PCI - IRQ = kernel bug??
In-Reply-To: <mailman.1008041221.4721.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1008041221.4721.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> what i find interesting is that no interrupts are being sent
> see for yourself here --> http://quail.no-ip.com/interrupts.txt

Your BIOS is broken.

> i've removed just about all devices from the system.... and there is no 
> change....

You should have posted the log as it looks _after_ pulling
the SCSI card.

Another thing to try is to use a 2.7.9-x kernel from RH updates
for 7.2 and use "apic" parameter. See if that helps.

-- Pete
