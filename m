Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVBIUJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVBIUJJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 15:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVBIUHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 15:07:44 -0500
Received: from mail01.hansenet.de ([213.191.73.61]:56788 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S261908AbVBIUEt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 15:04:49 -0500
Message-ID: <420A6CE9.4080603@web.de>
Date: Wed, 09 Feb 2005 21:04:57 +0100
From: Marcus Hartig <m.f.h@web.de>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rcX / 2.6.10-ac9 kernel do not more boot SATA disk on amd64
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I can not more boot any kernel >=2.6.11-rcX also >=2.6.10-ac9 and latest 
bk6. But I have here Alan Cox 2.6.10-ac8 and Cons 2.6.10-ck5 running and 
booting fine without any problems.

But now all kernel versions after that failed (with the same config tried) 
with:

mount: error 6 mounting ext3
...
umount /initrd/dev failed
...

on my Fedora Core 3 x86_64. The Fedora devel kernel also failed booting 
(2.6.11-rcX-bkX included and badly the SCSI support and all other as 
modules configured, what a shame... ;) .

I've tried compiling all needed drivers like libata, sata_nv, SCSI 
support, ext3 (my root / fs),... in the kernel and also the most as always 
as modules with an initrd. With and wo "noapic", direct device names to 
grub given and always no chance to get all at the top named kernel to boot.

What was there changed in this time? Or can anybody tell me, what I'm 
doing here wrong? :-(

Hardware: nForce3 250Gb MSI K8N Neo Mainboard, Samsung SATA 80GB disk, / 
fs on ext3, x86_64 kernel/Fedora and gcc 3.4.3.

config: http://www.marcush.de/config-2.6.11-rc3


Greetings,
Marcus
