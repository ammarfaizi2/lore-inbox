Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVJNOYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVJNOYS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 10:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVJNOYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 10:24:18 -0400
Received: from smtp.preteco.com ([200.68.93.225]:44012 "EHLO smtp.preteco.com")
	by vger.kernel.org with ESMTP id S1750757AbVJNOYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 10:24:17 -0400
Message-ID: <434FBF3F.2040604@rhla.com>
Date: Fri, 14 Oct 2005 11:22:55 -0300
From: =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@rhla.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, moliveira@latinsourcetech.com
Subject: Problems in kernel migration from 2.4 to 2.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

  I am migrating my linux laptop from a kernel 2.4.27-2  to a 2.6.12.6
one. Since I compiled the 2.6.12.6 kernel and booted my laptop, I am
receiving the following message when chose the 2.6.12.6 entry in the
grub menu:

mount: mount point dev does not exist
pivot_root: No such file or directory
/sbin/init: 432: cannot open dev/console: No such file
Kernel panic - not syncing: Attempted to kill init!

   But when I chose the 2.4.27 entry in the grub meno, my laptop boots ok!

   My laptop is running Debian Sarge 3.1a,  kernel 2.4.27-2 (that it is
booting ok) and kernel 2.4.6.12.6 (kernel.org kernel).  I compiled the
2.6.12.6 kernel with all needed modules (sata disk, ext3 ... including
devfs support), maked a initrd image with the necessary modules to mount
the / partition (sata modules, file system modules...) and changed the
disks names in the /etc/fstab from hda to sda (as it is recognized at
2.6.12.6 kernel bootup process). The laptop model is IBM Thinkpad T43.

Any ideia? Anybody knows why it is happen?

Thanks in advice.
Márcio Oliveira.

