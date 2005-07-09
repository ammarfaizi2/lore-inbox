Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVGIVgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVGIVgm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 17:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVGIVgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 17:36:42 -0400
Received: from mail-gateway-0-1.landonet.net ([196.25.111.196]:10665 "EHLO
	mail-gateway-0-1.landonet.net") by vger.kernel.org with ESMTP
	id S261742AbVGIVgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 17:36:41 -0400
Message-ID: <42D04364.5040407@lbsd.net>
Date: Sat, 09 Jul 2005 21:36:36 +0000
From: Nigel Kukard <nkukard@lbsd.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050706)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] bootutils v0.0.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Project Description:
BootUtils is a collection of utilities to facilitate booting of modern
Kernel 2.6 based systems. BootUtils is designed for initramfs, although
volunteers to add support for initrd are welcome. The process of finding
the root volume either by label or explicit label= on the kernel command
line, mounting it and 'switchroot'ing is automated. BootUtils can also
drop to emergency shell if the root volume cannot be mounted. Why not
even start sshd and allow admin login if the box is in a remote location?

Features:
* Automatic detection of root volume by label or explicit kernel
commandline option
* Supports ext2, ext3, jfs, reiserfs and xfs
* Emergency shell dropping in the case of a root volume problem
* Distribution independant

Changes:
* Added support to build with klibc
* Included libblkid/libuuid
* Fixed parsing of multiple root= kernel commandline options.

Website:
http://www.freshmeat.net/projects/bootutils/



Regards
Nigel Kukard
