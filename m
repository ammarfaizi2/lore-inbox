Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752100AbWJXHb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbWJXHb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 03:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbWJXHbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 03:31:25 -0400
Received: from [87.201.200.205] ([87.201.200.205]:10478 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S1752100AbWJXHbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 03:31:25 -0400
Message-ID: <453DC147.2020508@0Bits.COM>
Date: Tue, 24 Oct 2006 11:31:19 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Thunderbird 3.0a1 (X11/20061017)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: More uml build failures on 2.16.19-rc3 and 2.6.18.1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still having build failures on 2.6.18.1 and even the latest -rc3

Anyone ?
M

home /usr/src/sources/kernel/linux-2.6.18% !ma
make ARCH=um
   SYMLINK arch/um/include/kern_constants.h
   CC      arch/um/sys-i386/user-offsets.s
arch/um/sys-i386/user-offsets.c: In function 'foo':
arch/um/sys-i386/user-offsets.c:19: warning: implicit declaration of 
function 'offsetof'
arch/um/sys-i386/user-offsets.c:19: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:20: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:21: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:22: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:23: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:24: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:25: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:26: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:27: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:28: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:29: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:30: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:31: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:32: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:33: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:34: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:35: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:36: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:37: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:38: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:39: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:40: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:41: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:42: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:43: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:44: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:45: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:46: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:47: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:48: error: syntax error before 'struct'
make[1]: *** [arch/um/sys-i386/user-offsets.s] Error 1
make: *** [arch/um/sys-i386/user-offsets.s] Error 2
