Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbUERKtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUERKtr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 06:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUERKtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 06:49:47 -0400
Received: from dialpool2-178.dial.tijd.com ([62.112.11.178]:13696 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S262438AbUERKtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 06:49:45 -0400
From: Jan De Luyck <lkml@kcore.org>
To: Len Brown <len.brown@intel.com>
Subject: Re: [2.6.6] Synaptics driver is 'jumpy' -- FIXED
Date: Tue, 18 May 2004 12:49:41 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Alexander Bruder <anib@uni-paderborn.de>
References: <A6974D8E5F98D511BB910002A50A6647615FBC01@hdsmsx403.hd.intel.com> <1084821553.12352.358.camel@dhcppc4>
In-Reply-To: <1084821553.12352.358.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405181249.41787.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 May 2004 21:19, Len Brown wrote:
> On Mon, 2004-05-17 at 03:04, Jan De Luyck wrote:
> 2.6.6 dmesg:
>
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 11 12) *10
> ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 12
>
> Detected ipw2100 PCI device at 0000:02:04.0, dev: eth1, mem:
> 0xD0206000-0xD0206FFF -> e19e8000, irq: 12
>
> You need this patch:
> http://bugme.osdl.org/show_bug.cgi?id=2665

Thanks Len, this does the trick. 

Jan

-- 
His life was formal; his actions seemed ruled with a ruler.
