Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWFGXzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWFGXzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 19:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWFGXzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 19:55:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32419 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932467AbWFGXzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 19:55:38 -0400
Date: Wed, 7 Jun 2006 16:55:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: 2.6.17-rc6-mm1
Message-Id: <20060607165521.f4aa1898.akpm@osdl.org>
In-Reply-To: <44875DC0.2000406@mbligh.org>
References: <20060607104724.c5d3d730.akpm@osdl.org>
	<44875DC0.2000406@mbligh.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2006 16:14:08 -0700
Martin Bligh <mbligh@mbligh.org> wrote:

> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/
> 
> 
> 
> Build failures on everything but x86_64 (possibly different distro
> or something)
> 
>    GEN     usr/klibc/syscalls/SYSCALLS.i
> /usr/local/autobench/var/tmp/build/usr/klibc/SYSCALLS.def:30:26: missing 
> terminating ' character
> make[3]: *** [usr/klibc/syscalls/SYSCALLS.i] Error 1
> make[2]: *** [usr/klibc/syscalls] Error 2
> make[1]: *** [_usr_klibc] Error 2
> make: *** [usr] Error 2
> 06/07/06-18:23:44 Build the kernel. Failed rc = 2
> 06/07/06-18:23:44 build: kernel build Failed rc = 1
> 06/07/06-18:23:44 command complete: (2) rc=126
> Failed and terminated the run
>   Fatal error, aborting autorun

dammit, I fixed that and then didn't manage to include the fix in the rollup.

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/broken-out/klibc-ia64-fix.patch

