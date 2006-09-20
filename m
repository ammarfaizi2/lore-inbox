Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWITN1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWITN1Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWITN1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:27:25 -0400
Received: from [80.227.95.181] ([80.227.95.181]:57486 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S1751287AbWITN1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:27:24 -0400
Date: Wed, 20 Sep 2006 17:27:12 +0400 (GST)
From: Mitch@0Bits.COM
X-X-Sender: mitch@hasbox.com
Reply-To: Mitch@0Bits.COM
To: linux-kernel@vger.kernel.org
Subject: UML build failure with 2.6.18
Message-ID: <Pine.LNX.4.63.0609201724320.29128@hasbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

anyone having UML build failure with the shiny new 2.6.18


laptop /usr/src/sources/linux/linux-2.6.18# !ma
make ARCH=um
    SYMLINK arch/um/include/kern_constants.h
    SYMLINK arch/um/include/sysdep
make[1]: `arch/um/sys-i386/user-offsets.s' is up to date.
    CHK     arch/um/include/user_constants.h
    CHK     include/linux/version.h
    CHK     include/linux/compile.h
    CC      arch/um/os-Linux/process.o
arch/um/os-Linux/process.c:144: error: syntax error before 'getpid'
arch/um/os-Linux/process.c:146: warning: return type defaults to 'int'
arch/um/os-Linux/process.c:146: warning: function declaration isn't a
prototype
arch/um/os-Linux/process.c: In function '_syscall0':
arch/um/os-Linux/process.c:147: error: syntax error before '{' token
arch/um/os-Linux/process.c:162: error: syntax error before 'prot'
arch/um/os-Linux/process.c:209: error: parameter 'ok' is initialized
arch/um/os-Linux/process.c:211: error: syntax error before 'printk'
arch/um/os-Linux/process.c:279: error: syntax error before '*' token
make[1]: *** [arch/um/os-Linux/process.o] Error 1
make: *** [arch/um/os-Linux] Error 2




