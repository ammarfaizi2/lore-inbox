Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbUDPVdG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbUDPVc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:32:27 -0400
Received: from karnickel.franken.de ([193.141.110.11]:33293 "EHLO
	karnickel.franken.de") by vger.kernel.org with ESMTP
	id S263829AbUDPVaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:30:25 -0400
Subject: Re: Overlay ramdisk on filesystem?
From: Erik Tews <erik@debian.franken.de>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <407EF9C4.4070207@techsource.com>
References: <407EF9C4.4070207@techsource.com>
Content-Type: text/plain
Message-Id: <1082144290.4637.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Apr 2004 21:38:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do, den 15.04.2004 schrieb Timothy Miller um 23:08:
> I have a feeling that this may be a bit too off-topic, but I'm doing 
> some Linux and hardware performance tests, and some of the tests will 
> put the hardware into an unstable state which could get memory errors 
> which could cause filesystem corruption.
> 
> I would like to know how I could overlay a RAM disk over a read-only 
> filesystem so that all new files and modified files end up in the RAM 
> disk, but old files are read from the disk.  This way, when I reboot, 
> the disk reverts back.

This could be possible using a ramdisk, a filesystem on a disk (which
could be a read only block device like a cdrom too), device-mapper and
its snapshot-target. But I did not try yet.

