Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264090AbUCZRnx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 12:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbUCZRnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 12:43:53 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:19594 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S264090AbUCZRnv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 12:43:51 -0500
Date: Fri, 26 Mar 2004 10:43:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] asm-ppc/elf.h warning
Message-ID: <20040326174338.GB17402@smtp.west.cox.net>
References: <Pine.GSO.4.44.0403261425250.2460-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0403261425250.2460-100000@math.ut.ee>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 07:33:55PM +0200, Meelis Roos wrote:

> Just got this from current 2.6 BK:
> 
>   CC      arch/ppc/boot/simple/misc.o
> In file included from include/linux/elf.h:5,
>                  from arch/ppc/boot/simple/misc.c:20:
> include/asm/elf.h:102: warning: `struct task_struct' declared inside parameter list
> include/asm/elf.h:102: warning: its scope is only this definition or declaration, which is probably not what you want
> 
> This can be cured by either including linux/sched.h or defining
> struct task_struct;
> (like this - maybe it should be more close to the headers)

Can you try just removing <linux/elf.h> from everything in
arch/ppc/boot/ ?

-- 
Tom Rini
http://gate.crashing.org/~trini/
