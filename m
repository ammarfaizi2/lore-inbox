Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129837AbRB0UWe>; Tue, 27 Feb 2001 15:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129839AbRB0UWX>; Tue, 27 Feb 2001 15:22:23 -0500
Received: from [64.64.109.142] ([64.64.109.142]:23301 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S129837AbRB0UWN>; Tue, 27 Feb 2001 15:22:13 -0500
Message-ID: <3A9C0C54.88A6988C@didntduck.org>
Date: Tue, 27 Feb 2001 15:21:40 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob <rob@hereintown.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compilation problems
In-Reply-To: <Pine.LNX.4.30.0102271442010.967-100000@robsdigs.hereintown.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob wrote:
> 
> Hi, I've encountered a problem compiling the 2.4.2 kernel.
> 
> I downloaded the source, did a make menuconfig, make dep, make bzImage;
> everything went ok, but I didn't have the NIC working correctly. I
> recompiled, it seemed to go ok but still the NIC didn't work.  Then I
> tried make clean, make mrproper, make menuconfig, make dep, make bzImage,
> and now I keep getting an error at the very end of the compile process...
> 
> init/main.o(.text.init+0x53): undefined reference to
> `__buggy_fxsr_alignment'
> make: ***[vmlinux] Error 1
> 
> I've even tried removing the source tree and re extracting from the tar
> ball again but it always stops at the same place now.  If you have any
> ideas, please let me know.  I'm not a member of the list so a cc would
> really be great.

GCC version?

--

				Brian Gerst
