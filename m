Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268893AbRHFQ6i>; Mon, 6 Aug 2001 12:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268897AbRHFQ62>; Mon, 6 Aug 2001 12:58:28 -0400
Received: from ns3.keyaccesstech.com ([209.47.245.85]:37133 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S268893AbRHFQ6O>; Mon, 6 Aug 2001 12:58:14 -0400
Date: Mon, 6 Aug 2001 12:58:24 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Problems in using loadLin
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD043BC549@elway.lss.emc.com>
Message-ID: <Pine.LNX.4.33.0108061256530.1637-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001, chen, xiangping wrote:

> Hi,
>
> I am trying to use loadlin to boot up a machine. But after I
> replaced the bzImage, the kernel fails to boot up. It prints
> out error messages like:
> 	...
> 	VFS: Mounted root (ext2 filesystem) readonly
> 	Freeing unused kernel memory : 96K freed
> 	Warning: unable to open an initial console
> 	Kernel panic: No init found. Try passing init= option to kernel.
>
> The boot.bat file is:
> 	loadlin.exe bzImage ro root=0x0821
>
> Thanks,
>
> Xiangping

0x0821 represents /dev/sdc1. Did you build the SCSI driver into the kernel, or
do use an initrd?

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

