Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267594AbUHYPJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267594AbUHYPJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 11:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267669AbUHYPJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 11:09:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:19672 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S267594AbUHYPJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 11:09:47 -0400
Subject: 6 new compile/sparse warnings (daily build)
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1093446333.19925.4.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 25 Aug 2004 08:05:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compiler: gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
Arch: i386


Summary:
   New warnings = 6
   Fixed warnings = 2

New warnings:
-------------
drivers/usb/gadget/inode.c:693:17: warning: incorrect type in assignment
(different type sizes)
drivers/usb/gadget/inode.c:693:17:    expected int [usertype] (
*[addressable] [toplevel] ki_retry )( ... )
drivers/usb/gadget/inode.c:693:17:    got long ( static [addressable]
[toplevel] *<noident> )( ... )
drivers/usb/gadget/inode.c:693: warning: assignment from incompatible
pointer type

drivers/usb/gadget/inode.c:693:17: warning: incorrect type in assignment
(different type sizes)
drivers/usb/gadget/inode.c:693:17:    expected int [usertype] (
*[addressable] [toplevel] ki_retry )( ... )
drivers/usb/gadget/inode.c:693:17:    got long ( static [addressable]
[toplevel] *<noident> )( ... )

fs/aio.c:1322:39: warning: incorrect type in argument 2 (different
address spaces)
fs/aio.c:1322:39:    expected char [noderef] *<noident><asn:1>
fs/aio.c:1322:39:    got char *[addressable] [toplevel] ki_buf

fs/aio.c:1359:40: warning: incorrect type in argument 2 (different
address spaces)
fs/aio.c:1359:40:    expected char const [noderef] *<noident><asn:1>
fs/aio.c:1359:40:    got char *[addressable] [toplevel] ki_buf

fs/aio.c:1413:7: warning: incorrect type in argument 1 (different
address spaces)
fs/aio.c:1413:7:    expected void [noderef] *<noident><asn:1>
fs/aio.c:1413:7:    got char *[addressable] [toplevel] ki_buf

fs/aio.c:1425:7: warning: incorrect type in argument 1 (different
address spaces)
fs/aio.c:1425:7:    expected void [noderef] *<noident><asn:1>
fs/aio.c:1425:7:    got char *[addressable] [toplevel] ki_buf


Fixed warnings:
---------------
security/selinux/hooks.c:2825: warning: `ret' might be used
uninitialized in this function

security/selinux/hooks.c:2886: warning: `ret' might be used
uninitialized in this function



