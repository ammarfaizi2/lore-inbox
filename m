Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbUKSQny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUKSQny (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 11:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUKSQny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 11:43:54 -0500
Received: from math.ut.ee ([193.40.5.125]:29616 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261472AbUKSQnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 11:43:53 -0500
Date: Fri, 19 Nov 2004 18:15:44 +0200 (EET)
From: Meelis Roos <mroos@ut.ee>
To: matthieu castet <castet.matthieu@free.fr>
cc: linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
In-Reply-To: <419E17FF.1000503@free.fr>
Message-ID: <Pine.SOC.4.61.0411191813310.12562@math.ut.ee>
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr>
 <419E17FF.1000503@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> that's very strange : you must have 2 io entries, 1 dma entry and an irq 
>> entry.
>> Could you try pnpacpi from mm series ?
> no need : it is in rc2.
> So do you use pnpacpi ?
> If so, could you send your dsdt and try with pnpbios?

# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y

dmesg tells
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PnPBIOS: Disabled by ACPI

Will try disabling pnpacpi today.

How do I extract DSDT?

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
