Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267517AbUJLStr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbUJLStr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 14:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUJLStr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 14:49:47 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1806 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S267517AbUJLStn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 14:49:43 -0400
Date: Tue, 12 Oct 2004 20:49:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Hariprasad Nellitheertha <hari@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc4-mm1: CRASH_DUMP compile error with PROC_FS=n
Message-ID: <20041012184910.GD18579@stusta.de>
References: <20041011032502.299dc88d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 03:25:02AM -0700, Andrew Morton wrote:
>...
> All 741 patches
>...
> crashdump-elf-format-dump-file-access.patch
>   crashdump: ELF format dump file access
>...


This fails to compile with CONFIG_PROC_FS=n:


<--  snip  -->

...
  LD      .tmp_vmlinux1
kernel/built-in.o(.text+0x1d42b): In function `crash_create_proc_entry':
: undefined reference to `proc_vmcore'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

