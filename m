Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbTARFbl>; Sat, 18 Jan 2003 00:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbTARFbl>; Sat, 18 Jan 2003 00:31:41 -0500
Received: from ip68-107-168-92.lu.dl.cox.net ([68.107.168.92]:20864 "EHLO
	larry.yi.org") by vger.kernel.org with ESMTP id <S262528AbTARFbk>;
	Sat, 18 Jan 2003 00:31:40 -0500
Date: Fri, 17 Jan 2003 23:40:27 -0600
From: Larry <larrywyb@larry.yi.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 kernel modules will not load
Message-ID: <20030117234027.A709@larry.cox-internet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I just finished (a couple hours ago) building the 2.4.20 kernel
and modules and find that none of the modules will load.
Every one gives unresolved symbols errors and fails.

I tried building again, no luck, so I installed a newer version
of modutils ver 2.4.9 and rebuilt again with no luck. I checked 
the locations of modprobe, insmod and so on and made sure to
put them in the normal place for my system which is /sbin.
I also upgraded to make-3.79.1 and gcc-3.2.1.

Everything builds and installs fine but none of the modules will 
load.

Does anyone have any idea what may be the problem here? I searched 
the list archives and read about mod-init-tools, is this the same as
modutils? Will this cure the problem? And where do I get this?

My system is Slackware 8.1 
Here is the routine I follow to build kernels;

make menuconfig
make dep
make clean
make bzImage
make modules
make modules_install
copy System.map 
copy over the bzImage
edit lilo.conf 
run lilo
reboot

Please CC my personal address as well as the list.
Thanks you.

Larry


