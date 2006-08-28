Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWH1J6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWH1J6O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 05:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWH1J6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 05:58:14 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:46023 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964773AbWH1J6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 05:58:13 -0400
Date: Mon, 28 Aug 2006 05:50:08 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [2.6.17.11] strange pcie errors/warnings on Abit KN9-SLI
  mainboard
To: Jan De Luyck <ml_linuxkernel_20060528@kcore.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200608280554_MC3-1-C993-608@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200608280755.56015.ml_linuxkernel_20060528@kcore.org>

On Mon, 28 Aug 2006 07:55:55 +0200, Jan De Luyck wrote:

> Aug 27 15:35:04 whocares kernel: PCI: Setting latency timer of device 0000:00:0a.0 to 64
> Aug 27 15:35:04 whocares kernel: pcie_portdrv_probe->Dev[0376:10de] has invalid IRQ. Check vendor BIOS
> Aug 27 15:35:04 whocares kernel: assign_interrupt_mode Found MSI capability
> Aug 27 15:35:04 whocares kernel: Allocate Port Service[0000:00:0a.0:pcie00]
> Aug 27 15:35:04 whocares kernel: Allocate Port Service[0000:00:0a.0:pcie03]

Any other messages?  In addition to the above, I get:

PCI: Cannot allocate resource region 7 of bridge 0000:00:04.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:04.0
PCI: Cannot allocate resource region 9 of bridge 0000:00:04.0
PCI: Cannot allocate resource region 7 of bridge 0000:00:05.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:05.0

for my two pcie bridges.

Also please post 'lspci -v' output for one of the problem devices.

-- 
Chuck

