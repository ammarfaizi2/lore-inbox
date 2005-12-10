Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbVLJEVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbVLJEVX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 23:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbVLJEVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 23:21:23 -0500
Received: from main.gmane.org ([80.91.229.2]:50065 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964906AbVLJEVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 23:21:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Tom <harningt@gmail.com>
Subject: Re: Linux 2.6.15-rc5: off-line for a week
Date: Fri, 09 Dec 2005 23:07:47 -0500
Message-ID: <dndkaj$27f$2@sea.gmane.org>
References: <200512041526.19111.edmondo@eriadon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: harningt-2.user.msu.edu
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050721)
X-Accept-Language: en-us, en
In-Reply-To: <200512041526.19111.edmondo@eriadon.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edmondo Tommasina wrote:
> :-)
> 
> Linux 2.6.15-rc5 compiles fine and works as expected here.
> 
> lbalrog edmondo # uname -a
> Linux balrog 2.6.15-rc5 #1 SMP Sun Dec 4 14:42:04 CET 2005 x86_64
> AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ AuthenticAMD GNU/Linux
> 
> balrog edmondo # dmesg
> Bootdata ok (command line is root=/dev/hda5)
> Linux version 2.6.15-rc5 (root@balrog) (gcc version 4.0.2 (Gentoo 4.0.2-r1, pie-8.7.8)) #1 SMP Sun Dec 4 14:42:04 CET 2005
> (...)
> NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-7676  Fri Jul 29 13:15:16 PDT 2005
> X does an incomplete pfn remapping
> Call Trace:<ffffffff80168f80>{remap_pfn_range+176} <ffffffff882b70f3>{:nvidia:nv_verify_pci_config+392}
>        <ffffffff882babae>{:nvidia:os_pci_read_dword+35} <ffffffff882b7b76>{:nvidia:nv_kern_mmap+1273}
>        <ffffffff8016ed73>{do_mmap_pgoff+1251} <ffffffff801143fd>{sys_mmap+173}
>        <ffffffff8010dcaa>{system_call+126}
> X does an incomplete pfn remapping
> Call Trace:<ffffffff80168f80>{remap_pfn_range+176} <ffffffff882b70f3>{:nvidia:nv_verify_pci_config+392}
>        <ffffffff882babae>{:nvidia:os_pci_read_dword+35} <ffffffff882b7b76>{:nvidia:nv_kern_mmap+1273}
>        <ffffffff8016ed73>{do_mmap_pgoff+1251} <ffffffff801143fd>{sys_mmap+173}
>        <ffffffff8010dcaa>{system_call+126}
> X does an incomplete pfn remapping
> Call Trace:<ffffffff80168f80>{remap_pfn_range+176} <ffffffff882b70f3>{:nvidia:nv_verify_pci_config+392}
>        <ffffffff882babae>{:nvidia:os_pci_read_dword+35} <ffffffff882b7b76>{:nvidia:nv_kern_mmap+1273}
>        <ffffffff8016ed73>{do_mmap_pgoff+1251} <ffffffff801143fd>{sys_mmap+173}
>        <ffffffff8010dcaa>{system_call+126}
> X does an incomplete pfn remapping
> Call Trace:<ffffffff80168f80>{remap_pfn_range+176} <ffffffff882b70f3>{:nvidia:nv_verify_pci_config+392}
>        <ffffffff882babae>{:nvidia:os_pci_read_dword+35} <ffffffff882b7b76>{:nvidia:nv_kern_mmap+1273}
>        <ffffffff8016ed73>{do_mmap_pgoff+1251} <ffffffff801143fd>{sys_mmap+173}
>        <ffffffff8010dcaa>{system_call+126}
> (...)

I get that too... compiles and mostly works.

That pfn issue seems to affect my pointer device (Synaptic).
I've used both NVIDIA 7676 and the latest: 8174

Versions between 2.6.13-rc3 - 2.6.15-rc5 haven't worked (well.. I
hadn't tried out any 2.6.15 revisions until now).  I have 2.6.13-rc3
sitting back in case this pfn issue causes too much trouble.


Does anyone

