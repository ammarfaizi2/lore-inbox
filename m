Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbUK0HaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbUK0HaV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 02:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbUK0H1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 02:27:04 -0500
Received: from rosesmtp03.adp.com ([170.146.91.11]:6162 "EHLO
	rosesmtp03.adp.com") by vger.kernel.org with ESMTP id S261236AbUK0HY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 02:24:26 -0500
X-Server-Uuid: 44418BB9-D913-4AA8-A168-EE33603A6708
Message-ID: <2D1DF9BA9166D61188F30002B3A6E15318E4D826@ROSEEXCHMA>
From: Daniel_Weigert@adp.com
To: bunk@stusta.de, jpiszcz@lucidpixels.com
cc: linux-kernel@vger.kernel.org
Subject: RE: Kernel 2.6.9 SCSI driver compile error w/gcc-3.4.2.
Date: Wed, 24 Nov 2004 13:35:37 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
X-WSS-ID: 6DBA0BFC1J0721567-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Nov 2004 18:35:43.0716 (UTC) FILETIME=[68006A40:01C4D254]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> SNIP <<

>> root@p500b:/usr/src/linux# make modules
>>   CHK     include/linux/version.h
>> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>>   CC [M]  drivers/scsi/cpqfcTScontrol.o
>> drivers/scsi/cpqfcTScontrol.c:609:2: #error This is too much stack
>> drivers/scsi/cpqfcTScontrol.c:721:2: #error This is too much stack
>> make[2]: *** [drivers/scsi/cpqfcTScontrol.o] Error 1
>>...

>> SNIP << 
> It's known that some drivers do not compile and marked in the Kconfig 
> files. But if you choose to try to compile them anyway, they don't 
> compile.
> cu
>Adrian

The problem that I have with this, isn't that the driver is broken (it works
under 2.4), It isn't labeled as broken in the menuconfig, if you choose the
option to include the dubious drivers. Unfortunately, I do need this
particular driver and hope someone steps up to the plate to take care of it.

Dan


