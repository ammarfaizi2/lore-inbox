Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311147AbSCaBjj>; Sat, 30 Mar 2002 20:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311193AbSCaBja>; Sat, 30 Mar 2002 20:39:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41772 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S311147AbSCaBjW>; Sat, 30 Mar 2002 20:39:22 -0500
Date: Sat, 30 Mar 2002 18:33:07 -0700
From: ebiederm@xmission.com
Message-Id: <200203310133.SAA12760@frodo.biederman.org>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: [CFT][RFC] Linux/i386 boot protocol version 2.04
In-Reply-To: <m1d6xmuipv.fsf@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Mar 2002 18:33:07 -0700
In-Reply-To: <m1d6xmuipv.fsf@frodo.biederman.org>
Message-ID: <m14rixv7vw.fsf@frodo.biederman.org>
Lines: 29
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

ebiederm@xmission.com (Eric W. Biederman) writes:

> I have been doing some very weird things with booting the Linux kernel
> for a long time.  
>   - Entering the kernel in 32bit mode to avoid 16bit BIOS calls.  
>   - Converting bzImage into static ELF executables.  
>   - Hard coding a kernel command-line
>   - Going back to 16bit mode to make BIOS calls if necessary.
> 
> This version of the boot protocol should be fully backwards compatible
> but has new capabilities so I can do all of the above cleanly.
> 
> The current plan is to send this to Linus in the next couple of days
> as soon as he gets back.
> 
> 
> The patch series is at:
> ftp://download.lnxi.com/pub/src/linux-kernel-patches/boot/
> 
> The overall patch is:
> ftp://download.lnxi.com/pub/src/linux-kernel-patches/boot/linux-2.5.7.boot.diff
> 
> Anyway please tell me what you think.

For those having trouble getting in an alternative address is:
http://www.xmission.com/~ebiederm/files/boot/linux-2.5.7.boot.diff


Eric
