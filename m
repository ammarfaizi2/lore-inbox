Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317892AbSFMWMs>; Thu, 13 Jun 2002 18:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSFMWMr>; Thu, 13 Jun 2002 18:12:47 -0400
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:26503 "EHLO
	nika.frontier.iarc.uaf.edu") by vger.kernel.org with ESMTP
	id <S317890AbSFMWMo>; Thu, 13 Jun 2002 18:12:44 -0400
Date: Thu, 13 Jun 2002 14:13:02 -0800
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Two panic's while burning +700Mb file to cdr (2.4.19-pre7+)
Message-ID: <20020613221302.GD16291@iarc.uaf.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3D08E3E1.7050408@wkamphuis.student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-URL: [http://www.frontier.iarc.uaf.edu/~cswingle/]
X-Editor: VIM 6.1 [http://www.vim.org]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Walter,

* Wolter Kamphuis <kernel@wkamphuis.student.utwente.nl> [2002-Jun-13
* 10:26 AKDT]:
> I'm unsuccessfully trying to backup a large 738Mb file to cdr. While
> burning this file the machine panic's. Doing a emergency sync
> (alt+sysrq+s) or emergency unmount (alt+sysrq+u) gives an second
> panic.

Although not exactly the same as your experience, I have a dual CPU
AMD machine that locks up when burning CD-RW disks.  The CDRW drive
is an IDE device that is running under SCSI emulation.  When I turn
DMA off on that device (/sbin/hdparm -d 0 /dev/hdc) it works fine
without any panics.

In my case there was no Oops, the system simply locked up tight.
The power button was the only option despite having Ctrl-Alt-Delete in
inittab and putting Alt-Sys-Req in the kernel (2.4.18 and 2.4.19-pre7).

Might be worth a try. . .

Chris
-- 
Christopher S. Swingley           phone: 907-474-2689
Computer Systems Manager          email: cswingle@iarc.uaf.edu
IARC -- Frontier Program          GPG and PGP keys at my web page:
University of Alaska Fairbanks    www.frontier.iarc.uaf.edu/~cswingle
