Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSF2O6O>; Sat, 29 Jun 2002 10:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312962AbSF2O6N>; Sat, 29 Jun 2002 10:58:13 -0400
Received: from satan.intac.net ([199.173.52.34]:12305 "EHLO source.intac.net")
	by vger.kernel.org with ESMTP id <S312938AbSF2O6N>;
	Sat, 29 Jun 2002 10:58:13 -0400
Date: Sat, 29 Jun 2002 10:56:52 -0400 (EDT)
From: <kernellist@source.intac.net>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.7 (cant format with i=1024?)
Message-ID: <Pine.LNX.4.21.0206291048370.4087-100000@source.intac.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,
	I kickstart my boxes, and have run into something very odd with
kernel 2.4.7: In my post install script, I unmount a partition and I
reformat it so blocks and inodes are 1024(mkfs -b 1024 -i 1024
$partition/). But, this does not work on kernel 2.4.7. Anyone know what's
up? Ive been using kickstart since redhat 5.2 days and never have ran into
this type of problem. 

If I change the kernel to 2.4.18 then I can run mkfs -i 1024 ok, but then
kickstart wont work (the kernel wont install for some reason) :/

Anyway, anyone know why I can set to 1024 inodes per group on 2.4.7?

And if anyone might happen to know why you cant kickstart with a 2.4.18
kernel.

Thanks. I just woke up, so I apolgize if the above is not properly worded.



