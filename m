Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWFNHZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWFNHZE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 03:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWFNHZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 03:25:04 -0400
Received: from 62-99-178-133.static.adsl-line.inode.at ([62.99.178.133]:39569
	"HELO office-m.at") by vger.kernel.org with SMTP id S1750947AbWFNHZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 03:25:03 -0400
In-Reply-To: <6137A58D-963C-4379-A836-DCD28C3E88EE@office-m.at>
References: <6137A58D-963C-4379-A836-DCD28C3E88EE@office-m.at>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <24986DCE-B4DF-4A43-B6B4-C3FE2BE477F0@office-m.at>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Markus Biermaier <mbier@office-m.at>
Subject: Re: Can't Mount CF-Card on boot of 2.6.15 Kernel on EPIA - VFS: Cannot open root device
Date: Wed, 14 Jun 2006 09:25:00 +0200
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Am 13.06.2006 um 23:10 schrieb Markus Biermaier:

> So my "/tftpboot/pxelinux.cfg/Cxxxxxx" is:
> ------------------------- [ BEGIN Cxxxxxx ] -------------------------
> DEFAULT standard
> LABEL standard
> KERNEL vmlinuz
> # APPEND initrd=initrd ramdisk_size=32768 root=/dev/hde1 udev  
> acpi=off rootdelay=5
> APPEND initrd=initrd ramdisk_size=32768 root=2101 udev acpi=off  
> rootdelay=5
> ------------------------- [ END   Cxxxxxx ] -------------------------
>
> so the right root-string is: "root=2101".

Ok, the solution for *this problem* seems to be to write "root=2101".
But why can't I write "root=/dev/hde1" as in kernel 2.4.25?
Is this a kernel bug?
Or have I done an error somewhere?

Markus

