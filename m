Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273787AbRI3QuQ>; Sun, 30 Sep 2001 12:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273789AbRI3QuG>; Sun, 30 Sep 2001 12:50:06 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:34693 "EHLO ookhoi.xs4all.nl")
	by vger.kernel.org with ESMTP id <S273787AbRI3Qtx>;
	Sun, 30 Sep 2001 12:49:53 -0400
Date: Sun, 30 Sep 2001 18:50:17 +0200
From: Ookhoi <ookhoi@dds.nl>
To: Chris Meadors <clubneon@hereintown.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: boot/root floppies in modern times?
Message-ID: <20010930185017.H9327@humilis>
Reply-To: ookhoi@dds.nl
In-Reply-To: <Pine.LNX.4.33.0109291737270.1713-100000@clubneon.clubneon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109291737270.1713-100000@clubneon.clubneon.com>
User-Agent: Mutt/1.3.19i
X-Uptime: 20:50:40 up 1 day, 9 min,  9 users,  load average: 0.08, 0.12, 0.05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

> I got a new Thinkpad, it doesn't have an internal floppy drive.  Instead
> it has a USB floppy.  It can boot from the floppy just fine, I can get my
> custom boot disk's kernel loaded.  But when it comes to loading the root
> image I run into trouble.

I had the same problem with my vaio c1ve. Only a usb floppy drive, and
no way to let it read the second floppy disk or to make it mount root
via nfs as the nic got active after the bootp requests. 

I solved this by using one floppy with a initrd with enough tools to
download the drivers which were not in the kernel (for example usb &
scsi, or ide). You then just download the modules plus insmod on your
ramdisk and of you go. 

Hope this helps!

	Ookhoi
