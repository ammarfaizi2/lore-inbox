Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278572AbRJSSLK>; Fri, 19 Oct 2001 14:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278573AbRJSSLA>; Fri, 19 Oct 2001 14:11:00 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:19983 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S278572AbRJSSKt>;
	Fri, 19 Oct 2001 14:10:49 -0400
Date: Fri, 19 Oct 2001 11:13:21 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: 2.2.12 breaks fdisk
Message-ID: <Pine.LNX.4.10.10110191109350.10415-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somone break something?  I can only seem to access new partitions after a
reboot.

Calling ioctl() to re-read partition table.
rotyla:~# mkreiserfs /dev/hda4

<-------------mkreiserfs, 2001------------->
reiserfsprogs 3.x.0j

count_blocks: open failed (No such device or address)


rotyla:~# mke2fs /dev/hda4
mke2fs 1.25 (20-Sep-2001)
mke2fs: No such device or address while trying to determine filesystem
size


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

