Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbVBXU45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbVBXU45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 15:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVBXU45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 15:56:57 -0500
Received: from math.ut.ee ([193.40.36.2]:6097 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262480AbVBXUzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 15:55:47 -0500
Date: Thu, 24 Feb 2005 22:51:45 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Sven Luther <sven.luther@wanadoo.fr>
cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       Sven Hartge <hartge@ds9.gnuu.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christian Kujau <evil@g-house.de>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah)
 PCI IRQ map
In-Reply-To: <20050224170150.GA7746@pegasos>
Message-ID: <Pine.SOC.4.61.0502242250050.21289@math.ut.ee>
References: <20041206185416.GE7153@smtp.west.cox.net>
 <Pine.SOC.4.61.0502221031230.6097@math.ut.ee> <20050224074728.GA31434@pegasos>
 <Pine.SOC.4.61.0502241746450.21289@math.ut.ee> <20050224160657.GB11197@pegasos>
 <Pine.SOC.4.61.0502241832510.21289@math.ut.ee> <20050224170150.GA7746@pegasos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then just dd your /boot/vmlinuz-2.6.10-powerpc to your prep partition, or
> better yet to a tftp server, and try it out. If the scsi problems are there,
> can you fill a bug report against kernel-source-2.6.10 ?

Thanks for the new kernel. Just filed a bug report on 
kernel-source-2.6.10.

> You may probably want also to modify /etc/mkinitrd/mkinitrd:MODULES_DEP to dep
> instead of MOST, or you may hit size problems with your initrd, i would be
> interested in knowing that.

It worked without changing the module list, with 5.2M resulting vmlinuz.

-- 
Meelis Roos (mroos@linux.ee)
