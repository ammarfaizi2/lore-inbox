Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281430AbRKMCAj>; Mon, 12 Nov 2001 21:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281434AbRKMCAT>; Mon, 12 Nov 2001 21:00:19 -0500
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:46571 "EHLO
	smtprelay1.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S281430AbRKMCAR>; Mon, 12 Nov 2001 21:00:17 -0500
Date: Mon, 12 Nov 2001 21:01:58 -0500 (EST)
From: "Steven N. Hirsch" <shirsch@adelphia.net>
X-X-Sender: <hirsch@atx.fast.net>
To: <linux-kernel@vger.kernel.org>
Subject: fdisk doesn't know # of cylinders w/ 2.4.15pre2
Message-ID: <Pine.LNX.4.33.0111122057120.4249-100000@atx.fast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't seen any other reports of this, but fdisk is suddenly unable to 
figure out the geometry of unpartitioned SCSI drives with 2.4.15pre2!  It 
comes up complaining that the number of cylinders must be set at the 
expert menu.

If I reboot with 2.4.10-ac12 it works as it always did; assuming a 
reasonable geometry and permitting me to partition the disk.  Once 
partitioned, it IS recognized correctly by the newer kernel.

Quite repeatable.

Steve


