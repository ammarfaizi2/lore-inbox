Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310960AbSCHROf>; Fri, 8 Mar 2002 12:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310962AbSCHROc>; Fri, 8 Mar 2002 12:14:32 -0500
Received: from romulus.cl.urbanweb.net ([209.53.118.29]:62087 "HELO
	romulus.triluminary.net") by vger.kernel.org with SMTP
	id <S310961AbSCHROP>; Fri, 8 Mar 2002 12:14:15 -0500
Date: Mon, 4 Mar 2002 16:44:44 -0800
From: "Timothy M. Totten" <novus@triluminary.net>
To: linux-kernel@vger.kernel.org
Subject: Problem with Kernel
Message-ID: <20020304164444.A263@romulus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I am currently running Kernel 2.4.5 on my machine, and I
tried to install 2.4.18 and got a kernel panic. So I thought
I'de just make a new compile of 2.4.5 with only one change,
I set the High Memory support to 4GB instead of None.

	Right when the kernel should have been setting up the swap
space, instead it gave me the following message:

BUG IN DYNAMIC LINKER ld.so: rtld.c: 621: dl_main: Assertion `_dl_rtld_map.l_libname` failed!
Kernel panic: Attempted to kill init!

This is a different message than I was getting in 2.4.18
but happens at the same time in bootup.

The thing is, when I boot the original 2.4.5 it works fine.

They are both the same version from the same directory, and
only the High Memory support option has changed.

I'de like to get it working as having only 890 megs out of
1.75GB of RAM is kinda sucky since I just bought the RAM.

The machine is a Compaq Proliant 6000 "Quad Pentium Pro 200".

Thanks!

Timothy M. Totten

