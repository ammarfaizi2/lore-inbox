Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbVIVNpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbVIVNpg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbVIVNpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:45:36 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:54452 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1030319AbVIVNpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:45:35 -0400
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CE56193B-A4BB-4557-87C0-BFCC6B9E7E5B@freescale.com>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: kernel buildsystem error/warning?
Date: Thu, 22 Sep 2005 08:45:35 -0500
To: Sam Ravnborg <sam@ravnborg.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

I was wondering if anyone else is seeing the following error/warning  
when building a recent kernel.  This error seems to have been  
introduced between 2.6.13 and 2.6.14-rc1:

   CHK     include/linux/version.h
   CHK     include/linux/compile.h
   CHK     usr/initramfs_list
/bin/sh: line 1: +@: command not found
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      vmlinux
   SYSMAP  System.map


I'm building a cross compiled ARCH ppc kernel on an x86 host.  I  
tried using git bisect to track down the error but for some reason it  
ended up referencing a change before 2.6.13 which I really dont  
understand.

Anyways, let me know if you need more info on this.

thanks

- kumar
