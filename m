Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTLDSl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTLDSl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:41:56 -0500
Received: from gaia.cela.pl ([213.134.162.11]:8197 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S263310AbTLDSly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:41:54 -0500
Date: Thu, 4 Dec 2003 19:41:40 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
cc: Andre Tomt <lkml@tomt.net>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: lilo and system maps?
In-Reply-To: <20031204181504.GG16568@rdlg.net>
Message-ID: <Pine.LNX.4.44.0312041935170.26684-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> {0}:/usr/share/doc/lire>strings /boot/vmlinuz-2.6 | grep -i 2.[46] | head
> 2.6.0-test11-bk2 (root@wally) #3 SMP Thu Dec 4 12:41:42 EST 2003
> M2#6gbQ+
> {2 6B

Of course the correct solution is to have the kernel version in the file 
name...  and have linux-current or whatever as a symlink.  Besides truth 
be told the kernel version is far too little to identify a kernel anyway, 
there's also compilation options - they can change a lot - and all the 
patches which were/are applied to it.  I keep System.map-`uname -r`,
vmlinuz-`uname -r`, .config-`uname -r`, descr-`uname -r` in my /boot dirs 
- the first three come from the kernel and the last is a text file 
containing notes about what patches were applied (I keep an up to date 
descr file in each kernel source dir).

Cheers,
MaZe.

