Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263173AbVGIKQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbVGIKQs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 06:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbVGIKQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 06:16:48 -0400
Received: from nproxy.gmail.com ([64.233.182.193]:56671 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263173AbVGIKQs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 06:16:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=t3avEbJKx0u6D1rSRjzYbT5+13Vhl2HCZbcGUBSO1bjvkgN2zm1T825sDy4lqFm/J03VrzvIFGzN0bqIyI21QIzxTWGgOKfaI1WxafMa8jFEDg/9sOeQR8cJpSeH10lLjIETxdbpXufncBzgnJ2EvLoLktcRgH8NLclgiiFyG8E=
Message-ID: <a015f9a005070903165a6248fd@mail.gmail.com>
Date: Sat, 9 Jul 2005 12:16:46 +0200
From: Lance <molecularbiophysics@gmail.com>
Reply-To: Lance <molecularbiophysics@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: linux-kernel Cannot determine dependencies of module piix
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

I  get the message "Cannot determine dependencies of module piix"
while running mkinitrd. My apologies that this might me a very
"newbie" question. (until now I have compiled upto 2.6.11.12 without
any problems.

------------------
# make bzImage
# make modules
#make modules_install
# mkinitrd -k vmlinuz-2.6.12-custom -i initrd-2.6.12-custom  -b /boot
-s 1280x800
Root device:    /dev/hda6 (mounted on / as reiserfs)
Module list:    piix reiserfs

Kernel image:   /boot/vmlinuz-2.6.12-custom
Initrd image:   /boot/initrd-2.6.12-custom
Shared libs:    lib/ld-2.3.4.so lib/libblkid.so.1.0 lib/libc.so.6
lib/libselinux.so.1 lib/libuuid.so.1.2
Cannot determine dependencies of module piix. Is modules.dep up to date?
Driver modules:
none
Filesystem modules:     kernel/fs/reiserfs/reiserfs.ko
Including:      klibc initramfs udev fsck.reiserfs
Bootsplash:     Linux (1280x800)
5696 blocks
-------------------

The config file: 
http://www.geocities.com/whyagaintango/config.txt

How do I check "Is modules.dep up to date"

Many thanks
Lance
