Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbSL0OjF>; Fri, 27 Dec 2002 09:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbSL0OjF>; Fri, 27 Dec 2002 09:39:05 -0500
Received: from uni02du.unity.ncsu.edu ([152.1.13.102]:44672 "EHLO
	uni02du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id <S264945AbSL0OjE>; Fri, 27 Dec 2002 09:39:04 -0500
From: jlnance@unity.ncsu.edu
Date: Fri, 27 Dec 2002 09:47:18 -0500
To: linux-kernel@vger.kernel.org
Subject: Help with modules
Message-ID: <20021227144718.GA2567@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    I am having some problems using the 2.5.53 kernel because my module
scripts dont work.  I got the modutils-2.4.21-10 SRPM package from
ftp.kernel.org/pub/linux/kernel/people/rusty/modules. I verified that
it contains both the old modutils and the new module-init-tools source
code.  I built it and installed the resulting RPM on my Red Hat 8.0
machine.  When I boot, I get messages about modprobe failing:

 Dec 27 08:56:39 tricia modprobe: FATAL: Module hid not found.
 Dec 27 08:56:39 tricia rc.sysinit: Initializing USB HID interface:  failed
 Dec 27 08:56:39 tricia modprobe: FATAL: Module keybdev not found.
 Dec 27 08:56:39 tricia rc.sysinit: Initializing USB keyboard:  failed
 Dec 27 08:56:39 tricia modprobe: FATAL: Module mousedev not found.
 Dec 27 08:56:39 tricia rc.sysinit: Initializing USB mouse:  failed

and none of my modules get loaded.

If I boot the stock Red Hat 8.0 kernel using the new modutils, everything
seems to work fine (and its a lot more modular than the 2.5.53 kernel I
am trying to use).

I have a modules.conf file, but I think I read somewhere that the newer
modutils want a modprobe.conf file which I dont have.  That may be the
problem, but thats just a guess (and I dont know what should go in
that file).

I would certainly appreciate any suggestions anyone might have for fixing
my setup.  I would like to help test the 2.5.X kernels, but this has
been an difficult series of kernels to follow casually.  Hopefully this
is the last big obstacle.

Thanks,

Jim
