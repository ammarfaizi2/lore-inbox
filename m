Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbUEQXwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUEQXwe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUEQXwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:52:03 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:65186 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S263185AbUEQXuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:50:03 -0400
Date: Tue, 18 May 2004 01:50:00 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ramdisk driver in 2.6.6 has a severe bug
In-Reply-To: <20040517161943.37d826a3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0405180132240.21480-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2004, Andrew Morton wrote:

> "Robert M. Stockmann" <stock@stokkie.net> wrote:
> >
> > So basicly i copied all my files from rootmdk92 to the new rootmdk100 ramdisk.
> > But after copying them and umounting the old ramdisk (rootmdk92) en deleting
> >  /dev/loop0 , /dev/loop1 (which is /tmp/rootmdk100) loses all its contents.
> 
> ramdisks currently lose contents across umount.  I'm planning on getting it fixed
> by 2.6.7.
> 

Thanks,

Be aware of other problems when using the linux ramdisk driver,
loosing its contents. Especially the use of mkinitrd might result in 
unexpected problems. googling for "kernel 2.6.6 ramdisk problem" shows lots
of people with problems mounting their root filesystems and loading modules
from ramdisk. Klaus Knopper (knoppix) is not amused, neither am i :)

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

