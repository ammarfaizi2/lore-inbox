Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266160AbUAUXEV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 18:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUAUXEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 18:04:20 -0500
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:29573 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266160AbUAUXEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 18:04:12 -0500
From: Christian Unger <chakkerz@optusnet.com.au>
Reply-To: chakkerz@optusnet.com.au
Organization: naiv.sourceforge.net
To: linux-kernel@vger.kernel.org
Subject: Nvidia drivers and 2.6.x kernel
Date: Thu, 22 Jan 2004 10:04:06 +1100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401221004.06645.chakkerz@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone

I'm not sure if this has been done to death or not, but i can not get the 4496 
and 5328 versions of the NVidia kernel to work on the 2.6.1 version of (you 
guessed it) Linux.

I've googled about but not really found any great stuff. I did find this:

http://www.kerneltrap.org/node/view/1804
and from there the link to http://minion.de

I've tried it with both versions of the driver, with both versions of the 
drivers Makefile (Makefile.nvidia and Makefile.kbuild). 

With the installer and with just make install (make kernel_module_install).
The message i get is that the module is the wrong format.
The files that i can get to appear in:
/lib/modules/2.6.1/kernel/drivers/video are nvidia.ko & nvidia.o
Originally i thought they were the same file, but they have different sizes 
(afterall)
chakkerz@stormcrow:/lib/modules/2.6.1/kernel/drivers/video$ ls -l
total 4648
-rw-rw-r--    1 root     root      2376880 Jan 21 12:14 nvidia.ko
-rw-rw-r--    1 root     root      2376702 Jan 21 12:15 nvidia.o

so: i've tried unpatched, patched, old and new drivers, installer and make, 
make in the installers root, and it's sub director usr/src/nv ... oh yes, and 
different versions of the patch.

could someone please tell me where to find out how to make this work, because 
linux without GUI is little use to me.

In case it matters:
This is an AMD Athlon XP 2800+ on a Gigabyte GA-7N400 Pro2 MoBo (nforce2). The 
FFX is an Abit Siluro GeForce 4 Ti4200 OTES. 2 sticks of 256 Corsair DDR in 
dual channel. The kernel compiles i tried were with AGPGART integrated (and 
the nforce/nforce2 also integrated) as well as AGPGART as a module. Most of 
the stuff i tried with AGPGART as a module.
-- 
with kind regards,
  Christian Unger

"You don't need eyes to see, you need vision" (Faithless - Reverence)

  Mobile:            0402 268904
  Internet:          http://naiv.sourceforge.net
  NAIV Status:
     Stable       Testing       Development
      0.2.3r2      0.3.0         0.3.1 - File Handling

"May there be mercy on man and machine for their sins" (Animatrix)

