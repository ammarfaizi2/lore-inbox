Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282859AbRLBMBz>; Sun, 2 Dec 2001 07:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282845AbRLBMBq>; Sun, 2 Dec 2001 07:01:46 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:59115 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S282859AbRLBMBf>; Sun, 2 Dec 2001 07:01:35 -0500
Date: Sun, 2 Dec 2001 14:06:12 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: average user comments on 2.5.1-pre5
Message-ID: <Pine.LNX.4.33.0112021404290.14914-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I've just tried running 2.5.1-pre5 on my desktop machine and
noticed the following, when untarring medium sized files (kernel tarballs)
even from disk to disk (different channels) or moving large files around i
get mouse lag in X and after its done, and the flushing to disk begins the
interactive performance of the box takes a dive for the duration of that
disk activity. The last kernel i had before this was 2.4.13-ac7-preempt
which didn't exhibit this. 2.5.1-pre1 has the same problem.

The box is a P3-550/512M with disks doing UDMA33 on a PIIX4, the source
filesystem (where the tarballs are) is an ext3 one and destination is
ReiserFS (different disks/channels). The lag doesn't seem attributed to
CPU usage because the disk i/o barely hits the CPU (also checked via
xosview). VM performance on the other hand is quite nice, it does the
right thing a good majority of the time (unused stuff getting paged out,
proper cache/buffer usage) Main memory usage is a mixture of large
datasets and disk cache (multiple 500+ page PDFs being searched, whilst
doing various background compiles).

Regards,
	Zwane Mwaikambo


