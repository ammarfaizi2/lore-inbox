Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUCDNpk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbUCDNoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:44:12 -0500
Received: from thump.bur.st ([203.30.45.89]:16649 "EHLO thump.bur.st")
	by vger.kernel.org with ESMTP id S261903AbUCDNnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:43:49 -0500
Date: Thu, 4 Mar 2004 21:43:44 +0800
From: Trent Lloyd <lathiat@bur.st>
To: linux-kernel@vger.kernel.org
Subject: Re: Server suddenly freezes but awakes upon SysRq!?
Message-ID: <20040304134343.GA15402@thump.bur.st>
References: <20040304131915.GA15713@westend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304131915.GA15713@westend.com>
User-Agent: Mutt/1.3.28i
X-Random-Number: -inf
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen similar problems where the machines userspace seems to die but
it still pings etc and requires a reboot
This was on just P1/PPRO hardware, never figured it out. havent seen it
for quite some time
Haven't tried SQSRQ, if I see it again I'll try that.

Cheers,
Trent
Sixlabs

> Hello
> 
> We have some problems with a server that started to suddenly freeze
> every now and then which means that it does react to ping and tcp
> connects but does not allow a login nor returns the shell or does syslog
> write anything to disc or network.
> 
> Funnily it always immediately awakes when we presses 'AltGr+SysGr+h'
> although a login on the console did not work before.
> 
> What could be the cause of this "sleep" mode if a sysrq ends it?
> We noticed that at least 1-2 freezes occured right after accessing the
> external usb2.0 backup harddrive.
> 
> The server is a dual-p3 with a 3ware ide-scsi RAID and very low load as
> postfix+apache server.
> 
> bye,
> 
> -christian-
> 
> Some bits of the configuration:
> 
> ...
> CONFIG_MPENTIUMIII=y
> ...
> CONFIG_HIGHMEM4G=y
> # CONFIG_HIGHMEM64G is not set
> CONFIG_HIGHMEM=y
> CONFIG_HIGHIO=y
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> CONFIG_SMP=y
> CONFIG_NR_CPUS=32
> # CONFIG_X86_NUMA is not set
> # CONFIG_X86_TSC_DISABLE is not set
> CONFIG_X86_TSC=y
> CONFIG_HAVE_DEC_LOCK=y
> #
> # General setup
> #
> CONFIG_NET=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_ISA=y
> CONFIG_PCI_NAMES=y
> # CONFIG_EISA is not set
> # CONFIG_MCA is not set
> CONFIG_HOTPLUG=y
> ...
> # CONFIG_ACPI is not set
> CONFIG_ACPI_BOOT=y
> ...
> CONFIG_PNP=y
> CONFIG_ISAPNP=m
> ...
> CONFIG_DEBUG_STACKOVERFLOW=y
> # CONFIG_DEBUG_HIGHMEM is not set
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_DEBUG_IOVIRT is not set
> CONFIG_MAGIC_SYSRQ=y
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_FRAME_POINTER is not set
> CONFIG_LOG_BUF_SHIFT=0
> 
> -- 
> Christian Hammers             WESTEND GmbH  |  Internet-Business-Provider
> Technik                       CISCO Systems Partner - Authorized Reseller
>                               L?tticher Stra?e 10      Tel 0241/701333-11
> ch@westend.com                D-52064 Aachen              Fax 0241/911879
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
[ Trent "Lathiat" Lloyd  lathi@sixlabs.org ]/ "You sure as hell shouldn't be   \
[ tlhIngan Hol Dajatlh'e   www.sixlabs.org ]| fingering my toaster" -Linus     |
[ GPG Key Id: 0x04AB3C5D        www.bur.st ]| Torvalds, LCA2003 Speakers dinner|
[ IPv6 Conference  http://conf.sixlabs.org ]\ talking about ipv6 with me       /
