Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266884AbUJNSkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUJNSkR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUJNSbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:31:07 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:64264 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266879AbUJNRqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 13:46:15 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: root@chaos.analogic.com, Andries Brouwer <aebr@win.tue.nl>
Subject: Re: Linux-2.6.8 Hates DOS partitions
Date: Thu, 14 Oct 2004 20:45:28 +0300
User-Agent: KMail/1.5.4
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0410131329110.3818@chaos.analogic.com> <20041013213519.GA3379@pclin040.win.tue.nl> <Pine.LNX.4.61.0410131833370.12624@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0410131833370.12624@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410142045.28449.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just had to reinstall the "Fedora Linux 2" release from scratch the
> second time. What it does is, even though I told it to leave my
> SCSI disks alone, and even though I bought a new ATA Disk just for
> it, and even though I carefully told the installation program to
> use ONLY /dev/hda... Guess what? It installed a piece of GRUB
> on my first SCSI, /dev/sda, where the LILO boot-loader for DOS
> and linux-2.4.26 exists! It looks like it put it in a partition
> table!
> 
> So, every time I install a new Linux version, GRUB writes something
> else there. Eventually it probably gets big enough to make the DOS D: 
> partition go away, and soon DOS drive C: becomes unbootable. I can't
> find any other reason.

If you want to be sure that DOS boots, you may boot Linux by booting
into DOS first and then use loadlin/linld. I do it all the time.

> This is the second time I've had to reinstall everything from
> scratch in the past two weeks and I can tell you that there is
> nothing "free" about free software.

Bullshit. Commercial software can mess things up too.

Two weeks ago I personally witnessed how simple chkdsk
(standard one from NT install CD, not a fancy utility)
mangled NT4 domain controller's mirrored boot partition
to the point of "inaccessible boot device" BSOD.

It was not fun at all. Luckily I had a complete backup.
--
vda

