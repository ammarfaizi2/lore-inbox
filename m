Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVLDO0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVLDO0W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 09:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVLDO0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 09:26:21 -0500
Received: from 80-219-178-75.dclient.hispeed.ch ([80.219.178.75]:52450 "EHLO
	mx.eriadon.com") by vger.kernel.org with ESMTP id S932233AbVLDO0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 09:26:20 -0500
From: Edmondo Tommasina <edmondo@eriadon.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc5: off-line for a week
Date: Sun, 4 Dec 2005 15:26:19 +0100
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512041526.19111.edmondo@eriadon.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There's a rc5 out there now, largely because I'm going to be out of email 
> contact for the next week, and while I wish people were religiously 
> testing all the nightly snapshots, the fact is, you guys don't.

:-)

Linux 2.6.15-rc5 compiles fine and works as expected here.

lbalrog edmondo # uname -a
Linux balrog 2.6.15-rc5 #1 SMP Sun Dec 4 14:42:04 CET 2005 x86_64
AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ AuthenticAMD GNU/Linux

balrog edmondo # dmesg
Bootdata ok (command line is root=/dev/hda5)
Linux version 2.6.15-rc5 (root@balrog) (gcc version 4.0.2 (Gentoo 4.0.2-r1, pie-8.7.8)) #1 SMP Sun Dec 4 14:42:04 CET 2005
(...)
NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-7676  Fri Jul 29 13:15:16 PDT 2005
X does an incomplete pfn remapping
Call Trace:<ffffffff80168f80>{remap_pfn_range+176} <ffffffff882b70f3>{:nvidia:nv_verify_pci_config+392}
       <ffffffff882babae>{:nvidia:os_pci_read_dword+35} <ffffffff882b7b76>{:nvidia:nv_kern_mmap+1273}
       <ffffffff8016ed73>{do_mmap_pgoff+1251} <ffffffff801143fd>{sys_mmap+173}
       <ffffffff8010dcaa>{system_call+126}
X does an incomplete pfn remapping
Call Trace:<ffffffff80168f80>{remap_pfn_range+176} <ffffffff882b70f3>{:nvidia:nv_verify_pci_config+392}
       <ffffffff882babae>{:nvidia:os_pci_read_dword+35} <ffffffff882b7b76>{:nvidia:nv_kern_mmap+1273}
       <ffffffff8016ed73>{do_mmap_pgoff+1251} <ffffffff801143fd>{sys_mmap+173}
       <ffffffff8010dcaa>{system_call+126}
X does an incomplete pfn remapping
Call Trace:<ffffffff80168f80>{remap_pfn_range+176} <ffffffff882b70f3>{:nvidia:nv_verify_pci_config+392}
       <ffffffff882babae>{:nvidia:os_pci_read_dword+35} <ffffffff882b7b76>{:nvidia:nv_kern_mmap+1273}
       <ffffffff8016ed73>{do_mmap_pgoff+1251} <ffffffff801143fd>{sys_mmap+173}
       <ffffffff8010dcaa>{system_call+126}
X does an incomplete pfn remapping
Call Trace:<ffffffff80168f80>{remap_pfn_range+176} <ffffffff882b70f3>{:nvidia:nv_verify_pci_config+392}
       <ffffffff882babae>{:nvidia:os_pci_read_dword+35} <ffffffff882b7b76>{:nvidia:nv_kern_mmap+1273}
       <ffffffff8016ed73>{do_mmap_pgoff+1251} <ffffffff801143fd>{sys_mmap+173}
       <ffffffff8010dcaa>{system_call+126}
(...)

Thanks
edmondo
