Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264117AbUDREKa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 00:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264114AbUDREKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 00:10:30 -0400
Received: from [202.65.75.150] ([202.65.75.150]:44749 "EHLO
	pythia.bakeyournoodle.com") by vger.kernel.org with ESMTP
	id S264117AbUDREKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 00:10:22 -0400
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Sun, 18 Apr 2004 12:01:11 +0800
To: "Giacomo A. Catenazzi" <cate@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile error in main.c [2.6.bk]
Message-ID: <20040418040111.GR3445@bakeyournoodle.com>
Mail-Followup-To: "Giacomo A. Catenazzi" <cate@debian.org>,
	linux-kernel@vger.kernel.org
References: <407F821A.3040908@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407F821A.3040908@debian.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 08:50:02AM +0200, Giacomo A. Catenazzi wrote:
> Hello!
> 
> Since few days I cannot recompile the kernel.
> Do I have some very strange configuration?
> [ i386, pentium 4, SMP, $KB stack,...
> full .config at request]
> 
>   CC      init/main.o
> In file included from include/linux/proc_fs.h:6,
>                  from init/main.c:17:
> include/linux/fs.h:23:25: linux/audit.h: No such file or directory
> In file included from include/asm/irq.h:16,
>                  from include/linux/kernel_stat.h:5,
>                  from init/main.c:34:
> include/asm-i386/mach-default/irq_vectors.h:87:32: irq_vectors_limits.h: No 
> such file or directory
> In file included from init/main.c:34:
> include/linux/kernel_stat.h:28: error: `NR_IRQS' undeclared here (not in a 
> function)
> make[1]: *** [init/main.o] Error 1
> make: *** [init] Error 2

Either it is fixed in the bk2 snapshot or your .config is confused.

Grab bk2 if you're still getting the error post your .config and we'll
see wnat we can see.

Yours Tony

        linux.conf.au       http://lca2005.linux.org.au/
	Apr 18-23 2005      The Australian Linux Technical Conference!

