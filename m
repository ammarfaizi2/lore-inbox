Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269013AbUIXV6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269013AbUIXV6d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 17:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269015AbUIXV6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 17:58:33 -0400
Received: from mail.gmx.de ([213.165.64.20]:2770 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269013AbUIXV6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 17:58:30 -0400
X-Authenticated: #20450766
Date: Fri, 24 Sep 2004 22:39:12 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
cc: Takayoshi Kochi <t-kochi@bq.jp.nec.com>, bjorn.helgaas@hp.com,
       acpi-devel@lists.sourceforge.net, kaneshige.kenji@soft.fujitsu.com,
       akpm@osdl.org, greg@kroah.com, len.brown@intel.com, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [ACPI] [PATCH] PCI IRQ resource deallocation support [2/3]
In-Reply-To: <4153BEBA.5030202@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.60.0409242236330.7426@poirot.grange>
References: <414FEBDB.2050201@soft.fujitsu.com> <200409210857.59457.bjorn.helgaas@hp.com>
 <4150D458.3050400@jp.fujitsu.com> <20040924.145229.108814142.t-kochi@bq.jp.nec.com>
 <4153BEBA.5030202@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Kenji Kaneshige wrote:

> Takayoshi Kochi wrote:
> I'll change my patch to leave dev->irq as it is. And then I'll
> investigate about defining PCI_UNDEFINED_IRQ.

Some platforms (arm, arm26, ppc64) define a macro NO_IRQ:

include/asm-arm/irq.h:#define NO_IRQ        ((unsigned int)(-1))
include/asm-arm26/irq.h:#define NO_IRQ      ((unsigned int)(-1))
include/asm-ppc64/irq.h:#define NO_IRQ      (-1)

Thanks
Guennadi
---
Guennadi Liakhovetski

