Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277393AbRJJUBP>; Wed, 10 Oct 2001 16:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277392AbRJJUBH>; Wed, 10 Oct 2001 16:01:07 -0400
Received: from gulbis.latnet.lv ([159.148.108.9]:18949 "HELO gulbis.latnet.lv")
	by vger.kernel.org with SMTP id <S277390AbRJJUA4>;
	Wed, 10 Oct 2001 16:00:56 -0400
Date: Wed, 10 Oct 2001 23:01:26 +0300 (EEST)
From: Andris Pavenis <pavenis@latnet.lv>
To: linux-kernel@vger.kernel.org
Subject: 2.4.11: mount flag noexec still broken for VFAT partition
Message-ID: <Pine.LNX.4.21.0110102258290.28429-100000@gulbis.latnet.lv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Similary as with 2.4.10 mount flag noexec does not work for VFAT
partition. I have following in fstab

/dev/hda1      /c       vfat     noexec,gid=201,umask=002,quiet  1    0
/dev/hda5      /d       vfat     noexec,gid=201,umask=002,quiet  1    0

but I see that all files in corresponding filesystems are still 
exectuable

Andris

