Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWGCTGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWGCTGt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 15:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWGCTGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 15:06:49 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:2834 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1750842AbWGCTGs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 15:06:48 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm6
Date: Mon, 3 Jul 2006 20:07:11 +0100
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060703030355.420c7155.akpm@osdl.org>
In-Reply-To: <20060703030355.420c7155.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607032007.11782.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 July 2006 11:03, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17
>-mm6/

Haven't tried an -mm kernel for a while, but I'm getting some linker warnings 
(buggy linker)?

[alistair] 20:02 [~] as --version
GNU assembler 2.16.91.0.7 20060317

[alistair] 20:02 [~] gcc --version
gcc (GCC) 4.1.1

SYSCALL arch/x86_64/ia32/vsyscall-sysenter.so
/usr/bin/ld: warning: i386 architecture of input file 
`arch/x86_64/ia32/vsyscall-sysenter.o' is incompatible with i386:x86-64 
output

SYSCALL arch/x86_64/ia32/vsyscall-syscall.so
/usr/bin/ld: warning: i386 architecture of input file 
`arch/x86_64/ia32/vsyscall-syscall.o' is incompatible with i386:x86-64 output

  CC      kernel/lockdep.o
{standard input}: Assembler messages:
{standard input}:6223: Warning: .space or .fill with negative value, ignored
{standard input}:6682: Warning: .space or .fill with negative value, ignored
{standard input}:7332: Warning: .space or .fill with negative value, ignored
{standard input}:8134: Warning: .space or .fill with negative value, ignored
{standard input}:8305: Warning: .space or .fill with negative value, ignored

  LD      arch/x86_64/boot/compressed/vmlinux
ld: warning: i386:x86-64 architecture of input file 
`arch/x86_64/boot/compressed/head.o' is incompatible with i386 output

I get this last one on mainline too.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
