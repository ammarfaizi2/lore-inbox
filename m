Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131947AbRBKHaL>; Sun, 11 Feb 2001 02:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131948AbRBKHaB>; Sun, 11 Feb 2001 02:30:01 -0500
Received: from [200.243.227.68] ([200.243.227.68]:61961 "EHLO
	ns.netmaxi.com.br") by vger.kernel.org with ESMTP
	id <S131947AbRBKH3q>; Sun, 11 Feb 2001 02:29:46 -0500
From: Marcel Silva e Sousa <marcel@netmaxi.com.br>
Organization: Data Factory Inc.
To: linux-kernel@vger.kernel.org
Subject: OOPS: CRITICAL BUG IN KERNEL 2.4.0 and 2.4.1
Date: Sun, 11 Feb 2001 05:33:35 -0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01021105333500.02394@john>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, i see a critical bug in kernel version 2.4.0 and 2.4.1, look it:
i use Linux Slackware 7.1

My Hard Disk:
hda: IBM-DPTA-372730, ATA DISK drive
hda: 53464320 sectors (27374 MB) w/1961KiB Cache, CHS=3328/255/63, UDMA(33)

I have instaled in this hard disk 3 OS (OpenBSD, Linux Slack and Windows 2K 
(NTFS).

==============
OpenBSD --> 2GB
Linux -----> 7GB
Win2k ----> 18GB
==============

Windows2K is automount in fstab. When i run command "df -h" the values of 
capacity its REALLY wrong, look it:

[root@john /]:: df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda1             5.4G  3.7G  1.5G  71% /
/dev/hda2             143G  136G  6.8G  95% /mnt/hda2
[root@john /]:: 

When i had kernel 2.2.18 i did not have this problem....

Sorry for my really BAD English...

Att,
Marcel Silva e Sousa
marcel@netmaxi.com.br
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
