Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWINKKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWINKKg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 06:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWINKKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 06:10:36 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:51430 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750724AbWINKKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 06:10:36 -0400
Message-ID: <45092AB8.2050401@arcor.de>
Date: Thu, 14 Sep 2006 12:11:04 +0200
From: Jan Dinger <jan.dinger@arcor.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.18-rc7 Debian
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Ill compiling my own kernel. i´ve downloaded the archive and unpacked 
the archive.

This is my directory:

rwxrwsr-x  5 root src      4096 Sep 14 11:35 .
drwxr-xr-x 12 root root     4096 Jul 19 14:08 ..
drwxr-sr-x  2 root src      4096 Sep 14 11:54 kernel-patches
lrwxrwxrwx  1 root src        16 Sep 14 11:03 linux -> linux-2.6.18-rc7
drwxr-xr-x 19 root root     4096 Sep 14 11:36 linux-2.6.18-rc7
-rw-r--r--  1 root root 52467944 Sep 14 09:22 linux-2.6.18-rc7.tar.gz


Ok,

#make menuconfug
success

Next i will create my debian-package and will include the new patch.

# make-kpkg kernel_image --revision=jan-1.0 --append_to_version jan-1.0 
--added-patches=patch-2.6.18-rc7

The Error: debian/ruleset/misc/patches.mk:104: *** Could not find patch 
for patch-2.6.18-rc7.  Stop.

My patch is under /usr/src/kernel-patches/patch-2.6.18-rc7.

If i run the process without --added-patches, then i become this error:

====== making target configure-indep [new prereqs: 
stamp-configure-indep]======
====== making target stamp-configure [new prereqs: configure-arch 
configure-indep]======
Problems ecountered with the version number jan-1.0.
The upstream version jan does not contain a digit

Please re-read the README file and try again.
exit 2
make: *** [sanity_check] Error 2


Ich habe read the README and man pages again, but i cannt locate my 
mistake.

I hope everyone can help me.

So long

Jan




