Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUIALhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUIALhf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 07:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUIALhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:37:35 -0400
Received: from smtp2.poczta.onet.pl ([213.180.130.30]:20660 "EHLO
	smtp2.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S266137AbUIALhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:37:32 -0400
Message-ID: <4135B432.3090103@poczta.onet.pl>
Date: Wed, 01 Sep 2004 13:36:18 +0200
From: =?ISO-8859-1?Q?Maciej_G=F3rnicki?= <gutko@poczta.onet.pl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pl-PL; rv:1.7.2) Gecko/20040803
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.9-rc1-bk7]  LIBATA - "irq 11: nobody cared" on sil 3112a
References: <566B962EB122634D86E6EE29E83DD808182C4C22@hdsmsx403.hd.intel.com> <1094005073.20110.50.camel@linux>
In-Reply-To: <1094005073.20110.50.camel@linux>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> One of the entertaining things about NFORCE2 boxes is
> that their PCI interrupts are level/low in PIC mode
> and level/high in APIC mode.
> 
> I've got an NFORCE2 box, and it works either way,
> including putting both ohci_hcd and eth0 on irq 11
> at level/low in PIC mode like yours.
> 
> But in PIC mode I still get kernel: Disabling IRQ #7,
> so something isn't totally happy on this box.
> 
> I recommend that you try IOAPIC mode.
> 
>
yes i'm using it. there is my config in posted file too...
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

