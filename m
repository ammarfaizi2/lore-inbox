Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264678AbTFLKHn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 06:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbTFLKHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 06:07:43 -0400
Received: from sea2-f47.sea2.hotmail.com ([207.68.165.47]:5390 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264678AbTFLKHA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 06:07:00 -0400
X-Originating-IP: [194.7.240.2]
X-Originating-Email: [lode_leroy@hotmail.com]
From: "lode leroy" <lode_leroy@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: lode_leroy@hotmail.com
Subject: Q: how to run linux in a diskimage on NTFS
Date: Thu, 12 Jun 2003 12:20:45 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F47ZxNIeA8UJ4E0002e414@hotmail.com>
X-OriginalArrivalTime: 12 Jun 2003 10:20:45.0678 (UTC) FILETIME=[493E30E0:01C330CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I want to run linux on an embedded system that does
not have a CDROM or FLOPPY, so the only possibility
is to go over the network.

The machine is running WinXP, and I would prefer not
to install a boot manager, or destroy the filesystem,
which is NTFS.

Is there a possibility to do the following:

1) put the following files on the NTFS partition:
	bootsector  (<- don't know how to create this one)
	bootmanager (<- don't know what to put here)
	kernel image
	ramdisk image
	disk image
2) call the bootsector from NTLDR
3) call the bootmanager from the bootsector
4) load the kernel and ramdisk image from the bootmanager
5) mount the NTFS partition READ-WRITE
6) mount the disk image READ-WRITE over the loopback device

7) if possible, disable NTFS/WRITE for anything but the disk image.


Can anyone advise me on which bootmanager to use?
Can anyone tell me if this is possible?

-- lode

ps: please CC me directly

_________________________________________________________________
MSN Search, for relevant search results! http://search.msn.be

