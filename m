Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWDCTrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWDCTrd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 15:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWDCTrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 15:47:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58127 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964857AbWDCTrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 15:47:32 -0400
Date: Mon, 3 Apr 2006 20:47:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: schierlm@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc1
Message-ID: <20060403194727.GD5616@flint.arm.linux.org.uk>
Mail-Followup-To: schierlm@gmx.de, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org> <e0r09j$gu5$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0r09j$gu5$1@sea.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 01:18:12PM +0200, Michael Schierl wrote:
> Linus Torvalds wrote:
> 
> > For the rest of you, there's the tar-balls, patches, and full ChangeLog.
> 
> Does not build here:
> 
> [...]
>   LD      arch/i386/lib/built-in.o
>   CC      arch/i386/lib/bitops.o
>   AS      arch/i386/lib/checksum.o
>   CC      arch/i386/lib/delay.o
>   AS      arch/i386/lib/getuser.o
>   CC      arch/i386/lib/memcpy.o
>   AS      arch/i386/lib/putuser.o
>   CC      arch/i386/lib/strstr.o
>   CC      arch/i386/lib/usercopy.o
>   AR      arch/i386/lib/lib.a
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> kernel/built-in.o:(.data+0x758): undefined reference to `uevent_helper'
> make: *** [.tmp_vmlinux1] Error 1

I've reported this bug several times but I seem to be getting absolutely
no response.  So I submitted it to bugzilla.

http://bugzilla.kernel.org/show_bug.cgi?id=6306

Feel free to add your voice to that bug to try to get someone to fix it.
I'm not hopeful though.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
