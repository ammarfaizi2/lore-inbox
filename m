Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbUKIQd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUKIQd4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 11:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUKIQdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 11:33:18 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59110 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261578AbUKIQcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 11:32:23 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm4
Date: Tue, 9 Nov 2004 11:32:15 -0500
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20041109074909.3f287966.akpm@osdl.org>
In-Reply-To: <20041109074909.3f287966.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411091132.15189.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, November 09, 2004 10:49 am, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.
>6.10-rc1-mm4/

I get this build error when I enable x86 support on ia64:

  CC      arch/ia64/ia32/binfmt_elf32.o
In file included from arch/ia64/ia32/binfmt_elf32.c:47:
arch/ia64/ia32/../../../fs/binfmt_elf.c:721:60: macro "setup_arg_pages" passed 
3 arguments, but takes just 2
In file included from arch/ia64/ia32/binfmt_elf32.c:47:
arch/ia64/ia32/../../../fs/binfmt_elf.c: In function `load_elf_binary':
arch/ia64/ia32/../../../fs/binfmt_elf.c:721: warning: assignment makes integer 
from pointer without a cast
make[1]: *** [arch/ia64/ia32/binfmt_elf32.o] Error 1
make: *** [arch/ia64/ia32] Error 2

Other than that, it builds and comes up fine with sn2_defconfig.

Jesse
