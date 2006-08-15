Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbWHONMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWHONMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 09:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbWHONMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 09:12:23 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:43453 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965097AbWHONMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 09:12:22 -0400
Date: Tue, 15 Aug 2006 15:11:32 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andi Kleen <ak@suse.de>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4 warning on arch/x86_64/boot/compressed/head.o
In-Reply-To: <Pine.LNX.4.61.0608100911160.10926@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0608151510400.29937@yvahk01.tjqt.qr>
References: <7161.1155005268@kao2.melbourne.sgi.com> <200608080455.34702.ak@suse.de>
 <Pine.LNX.4.61.0608090823570.11585@yvahk01.tjqt.qr> <200608090909.19985.ak@suse.de>
 <Pine.LNX.4.61.0608100911160.10926@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I wrote:
>>>>>Andi Kleen wrote:
>>>>> Compiling 2.6.18-rc4 on x86_64 gets this warning.
>>>>> 
>>>>>   gcc -Wp,-MD,arch/x86_64/boot/compressed/.head.o.d  -nostdinc -isystem /usr/lib64/gcc/x86_64-suse-linux/4.1.0/include -D__KERNEL__ -Iinclude -Iinclude2 -I$KBUILD_OUTPUT/linux/include -include include/linux/autoconf.h -D__ASSEMBLY__ -m64 -traditional -m32  -c -o arch/x86_64/boot/compressed/head.o $KBUILD_OUTPUT/linux/arch/x86_64/boot/compressed/head.S
>>>>>   ld -m elf_i386  -Ttext 0x100000 -e startup_32 -m elf_i386 arch/x86_64/boot/compressed/head.o arch/x86_64/boot/compressed/misc.o arch/x86_64/boot/compressed/piggy.o -o arch/x86_64/boot/compressed/vmlinux 
>>>>> ld: warning: i386:x86-64 architecture of input file `arch/x86_64/boot/compressed/head.o' is incompatible with i386 output
[...]
>Ok here:
[...]


Any results on this, Andi?


Jan Engelhardt
-- 
