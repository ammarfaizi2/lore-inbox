Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbUKLOMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbUKLOMJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 09:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbUKLOMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 09:12:09 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:33671 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S262492AbUKLOMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 09:12:03 -0500
Date: Fri, 12 Nov 2004 14:12:02 +0000
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: /proc/bus/i2c is missing
Message-ID: <20041112141202.GA19781@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

linux 2.6.8.1

I insmoded i2c-parport and pcf8591 modules and i2c-1 appeared in my /dev
(previously, only i2c-0 was there):

	clock@oberon:~$ ls /dev/i2* 
	/dev/i2c-0  /dev/i2c-1
	
	/dev/i2c:
	0  1

/usr/src/linux/Documentation/i2c says "You can
examine /proc/bus/i2c to see what number corresponds to which adapter."
I don't have any /proc/i2c:

	clock@oberon:~$ ls /proc/i2c
	ls: /proc/i2c: No such file or directory

However, I have /proc:
	clock@oberon:~$ ls /proc
	             devices      mtrr
	             diskstats    net
	             dma          partitions
	             driver       pci
	             execdomains  scsi
	             filesystems  self
	             fs           slabinfo
	             ide          stat
	             interrupts   swaps
	  [...]      iomem        sys
	             ioports      sysrq-trigger
	             irq          sysvipc
	             kallsyms     tty
	             kcore        uptime
	             kmsg         version
	             loadavg      vmstat
	             locks
	  buddyinfo  mdstat
	  bus        meminfo
	  cmdline    misc
	  config.gz  modules
	  cpuinfo    mounts

How can I make /proc/i2c appear?

Cl<
