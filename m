Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272333AbTHSRtq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272602AbTHSRIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:08:11 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.29]:65216 "EHLO
	mwinf0201.wanadoo.fr") by vger.kernel.org with ESMTP
	id S272765AbTHSQyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:54:35 -0400
From: jjluza <jjluza@yahoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: problem with test3-mm3 and nvidia drivers
Date: Tue, 19 Aug 2003 18:54:44 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308191854.44075.jjluza@yahoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oups, sorry, 2 mistakes :
- it's not "I worked with test3-mm1 and older release." but "It worked with 
test3-mm1 and older release."
- and I forgot the error message at compile time (really sorry) :


make[1]: Entering directory `/usr/src/linux-2.6.0-test3-mm3'
  CHK     include/linux/version.h
make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
*** Warning: Overriding SUBDIRS on the command line can cause
***          inconsistencies
  CC [M]  /usr/src/nvidia/deto/NVIDIA-Linux-x86-1.0-4496-pkg2/usr/src/nv/nv.o
/usr/src/nvidia/deto/NVIDIA-Linux-x86-1.0-4496-pkg2/usr/src/nv/nv.c: In 
function `nv_kern_read_agpinfo':
/usr/src/nvidia/deto/NVIDIA-Linux-x86-1.0-4496-pkg2/usr/src/nv/nv.c:1964: 
error: structure has no member named `name'
make[2]: *** 
[/usr/src/nvidia/deto/NVIDIA-Linux-x86-1.0-4496-pkg2/usr/src/nv/nv.o] Error 1
make[1]: *** [/usr/src/nvidia/deto/NVIDIA-Linux-x86-1.0-4496-pkg2/usr/src/nv] 
Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.0-test3-mm3'
nvidia.ko failed to build!
make: *** [module] Error 1


> It worked for me under -mm2.
Ok, so the changes are certainly made between mm2 and mm3

