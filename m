Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275051AbRIYQJm>; Tue, 25 Sep 2001 12:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275064AbRIYQJW>; Tue, 25 Sep 2001 12:09:22 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9889 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S275051AbRIYQJL>;
	Tue, 25 Sep 2001 12:09:11 -0400
Date: Tue, 25 Sep 2001 12:09:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: all files are executable in vfat
In-Reply-To: <ISPFE83Y8pEBtKarvzr000007ff@mail.takas.lt>
Message-ID: <Pine.GSO.4.21.0109251207290.24321-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Sep 2001, Nerijus Baliunas wrote:

> Hello,
> 
> All files are executable in vfat (kernel 2.4.10), although I have
> /dev/hda1  /mnt/c   vfat   defaults,user,noexec,umask=0,quiet 0 0
> in /etc/fstab. They were not in 2.4.7.

Really? Try to execute a binary from there.  cp /bin/ls /mnt/c && /mnt/c/ls

