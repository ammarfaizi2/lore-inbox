Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286289AbRL0PXu>; Thu, 27 Dec 2001 10:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286294AbRL0PXk>; Thu, 27 Dec 2001 10:23:40 -0500
Received: from Expansa.sns.it ([192.167.206.189]:46604 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S286289AbRL0PX3>;
	Thu, 27 Dec 2001 10:23:29 -0500
Date: Thu, 27 Dec 2001 16:23:32 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: <linux-kernel@vger.kernel.org>
Subject: reiserfs does not work with linux 2.4.17 on sparc64 CPUs
Message-ID: <Pine.LNX.4.33.0112271607570.24247-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,
I just upgraded to kernel 2.4.17 on a ultra2, sparc64, with 2 scsi disks.

My system was on reiserfs,except for root partition, but the kernel 2.4.17
is unable to mount reiserFS partitions.
At boot i get an oops during the mount, but sincer I have no syslogd
running I am not able to log it. Anyway the message talk about not been
able to load a table map.

gone back (sig!) to 2.4.16

on x86 processors, instead, reiserfs semms to work as usual

Luigi



