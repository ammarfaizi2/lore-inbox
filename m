Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVCGMsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVCGMsH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 07:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVCGMsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 07:48:07 -0500
Received: from bay24-f18.bay24.hotmail.com ([64.4.18.68]:42759 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261475AbVCGMsD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 07:48:03 -0500
Message-ID: <BAY24-F18AB80179386A2AAB4DCEAD85F0@phx.gbl>
X-Originating-IP: [212.18.59.124]
X-Originating-Email: [janprunk@hotmail.com]
From: "Jan Prunk" <janprunk@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: debian kernel 2.4.29
Date: Mon, 07 Mar 2005 12:48:01 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 07 Mar 2005 12:48:02.0406 (UTC) FILETIME=[E63D6060:01C52313]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

I tried to compile kernel 2.4.29 on a debian PARISC machine Gecko 712/60, 
using PA7100LC processor.
I executed command to build a custom debian kernel:
fakeroot make-kpkg --revision=custom.1.0 kernel_image

The kernel config file is available here:
http://212.18.59.124/kernel-2.4.29/config

The errors in the kernel are following:
signal.c:66: warning: passing arg 1 of `__put_kernel_asm64' makes
integer from pointer without a cast
signal.c:66: warning: passing arg 1 of `__put_user_asm64' makes integer
from pointer without a cast
gcc -D__ASSEMBLY__ -traditional -D__KERNEL__
-I/usr/src/linux-2.4.29/include  -c -o hpmc.o hpmc.S
gcc -D__ASSEMBLY__ -traditional -D__KERNEL__
-I/usr/src/linux-2.4.29/include  -c -o real2.o real2.S
real2.S: Assembler messages:
real2.S:126: Error: too many positional arguments
make[2]: *** [real2.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.29/arch/parisc/kernel'
make[1]: *** [_dir_arch/parisc/kernel] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.29'
make: *** [stamp-build] Error 2

If you happen to know how to make this work, I appreciate a copy of your 
email to my address.

Regards, Jan Prunk

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

