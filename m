Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVGVF5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVGVF5A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 01:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVGVF47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 01:56:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:57535 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262041AbVGVF47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 01:56:59 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: sboyce@blueyonder.co.uk
cc: linux-kernel@vger.kernel.org
Subject: Re: kdb v4.4 supports OHCI keyboard in 2.6 
In-reply-to: Your message of "Thu, 21 Jul 2005 12:11:21 +0100."
             <42DF82D9.30202@blueyonder.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Jul 2005 15:56:53 +1000
Message-ID: <11122.1122011813@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2005 12:11:21 +0100, 
Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>   CHK     include/linux/version.h
>make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
>   CC      arch/i386/kernel/traps.o
>arch/i386/kernel/traps.c:809: error: redefinition of `do_int3'
>arch/i386/kernel/traps.c:709: error: `do_int3' previously defined here
>make[1]: *** [arch/i386/kernel/traps.o] Error 1
>make: *** [arch/i386/kernel] Error 2
>
>Both lines are the same, enabling both kprobes and kdb causes the error, 
>so kprobes must be deselected.

Fixed in kdb-v4.4-2.6.13-rc3-common-2 + kdb-v4.4-2.6.13-rc3-i386-2.

