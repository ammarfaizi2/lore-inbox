Return-Path: <linux-kernel-owner+w=401wt.eu-S1752903AbWLVVxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbWLVVxM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 16:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752928AbWLVVxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 16:53:12 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34180 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbWLVVxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 16:53:11 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <458C5389.70704@s5r6.in-berlin.de>
Date: Fri, 22 Dec 2006 22:52:09 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: Randy Dunlap <randy.dunlap@oracle.com>, Greg KH <greg@kroah.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       e1000-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 1/5] Update Documentation/pci.txt
References: <456404E2.1060102@jp.fujitsu.com>	<20061122182804.GE378@colo.lackof.org>	<45663EE8.1080708@jp.fujitsu.com>	<20061124051217.GB8202@colo.lackof.org>	<20061206072651.GG17199@kroah.com>	<20061210072508.GA12272@colo.lackof.org>	<20061215170207.GB15058@kroah.com>	<20061218071133.GA1738@colo.lackof.org> <20061222114658.01da661b.randy.dunlap@oracle.com>
In-Reply-To: <20061222114658.01da661b.randy.dunlap@oracle.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 18 Dec 2006 00:11:33 -0700 Grant Grundler wrote:
...
>> +4.1 Stop IRQs on the device
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +How to do this is chip/device specific. If it's not done, it opens
>> +the possibility of a "screaming interrupt" if (and only if)
>> +the IRQ is shared with another device.
>> +
>> +When the shared IRQ handler is "unhoooked", the remaining devices
                                       ^^^
-> unhooked

...
>> +11. MMIO Space and "Write Posting"
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +Converting a driver from using I/O Port space to using MMIO space
>> +often requires some additional changes. Specifically, "write posting"
>> +needs to be handled. Many drivers (e.g. tg3, acenic, sym53c8xx_2)
>> +already do. I/O Port space guarantees write transactions reach the PCI
> 
>    already do this.
> 
>> +device before the CPU can continue. Writes to MMIO space allow to CPU
                                                                   ^^
>> +continue before the transaction reaches the PCI device. HW weenies
   ^
-> allow the CPU to continue

-- 
Stefan Richter
-=====-=-==- ==-- =-==-
http://arcgraph.de/sr/
