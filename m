Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266579AbUBLUwI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 15:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266590AbUBLUwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 15:52:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:15237 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266579AbUBLUwD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 15:52:03 -0500
Date: Thu, 12 Feb 2004 15:45:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Gopi Palaniappan <gpalani1@urbana.css.mot.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: memory foorprint of kernel modules
In-Reply-To: <BDEMIINGEPCMIFLFPKCKCEFDCCAA.gpalani1@urbana.css.mot.com>
Message-ID: <Pine.LNX.4.53.0402121543070.28272@chaos>
References: <BDEMIINGEPCMIFLFPKCKCEFDCCAA.gpalani1@urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004, Gopi Palaniappan wrote:

> Is there an easy way to measure the memory/RAM footprint of dynamically
> loaded kernel modules?
> Are there tools similar to "pmap" for this purpose?
>
> thanks,
> Gopi
> --
> Motorola Inc.
> Personal Communications Sector,
> Urbana-Champaign Design Center,
> 1800 S. Oak St, Champaign, IL 61820.
>

You might make some sense of /proc/ksyms...

This is for a module called ramdisk.

Script started on Thu Feb 12 15:41:10 2004
cd /proc
# strings ksyms | grep ramdisk
[ramdisk]
[ramdisk]
[ramdisk]
[ramdisk]
[ramdisk]
[ramdisk]
[ramdisk]
[ramdisk]
d4a19510 __insmod_ramdisk_S.bss_L4
[ramdisk]
d4a19100 __insmod_ramdisk_S.rodata_L563
[ramdisk]
[ramdisk]
[ramdisk]
d4a18000 __insmod_ramdisk_O/root/Message-Based/drivers/target/ramdisk.o_M4027E0AD_V132120
[ramdisk]
[ramdisk]
[ramdisk]
[ramdisk]
d4a18054 __insmod_ramdisk_S.text_L4237
[ramdisk]
[ramdisk]
[ramdisk]
[ramdisk]
d4a19398 __insmod_ramdisk_S.data_L5
[ramdisk]
# exit
exit
Script done on Thu Feb 12 15:41:45 2004



Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


