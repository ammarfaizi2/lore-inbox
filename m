Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264709AbTFFILC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 04:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbTFFILC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 04:11:02 -0400
Received: from ns.suse.de ([213.95.15.193]:50699 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264709AbTFFILC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 04:11:02 -0400
Date: Fri, 6 Jun 2003 10:24:34 +0200
From: Andi Kleen <ak@suse.de>
To: Warren Togami <warren@togami.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-rc7 AMD64 dpt_i2o fails compile
Message-ID: <20030606082434.GD14382@wotan.suse.de>
References: <1054789161.3699.67.camel@laptop.suse.lists.linux.kernel> <20030605010841.A29837@devserv.devel.redhat.com.suse.lists.linux.kernel> <1054799692.3699.77.camel@laptop.suse.lists.linux.kernel> <1054808477.15276.0.camel@dhcp22.swansea.linux.org.uk.suse.lists.linux.kernel> <p73wug067qb.fsf@oldwotan.suse.de> <1054842344.15457.43.camel@dhcp22.swansea.linux.org.uk> <1054877581.3699.113.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054877581.3699.113.camel@laptop>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Adaptec SCSI RAID 2110S claims to be a "64-bit/66MHz PCI-to-SCSI RAID
> card".  The physical card is longer than normal 32-bit PCI cards with
> more pins that fit into a "64-bit PCI slot".  Are Adaptec's claims of
> 64-bit hardware false?

They are refering to 64bit PCI. That is not the same as support for 64bit
operating systems.  An 64bit OS can also support non 64bit hardware, but it
needs proper support in the driver which the current linux driver doesn't 
have.

You will have to wait until somebody fixes the driver.

-Andi
