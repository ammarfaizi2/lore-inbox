Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbTDKTcb (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTDKTcb (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:32:31 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:14576 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S261570AbTDKTca (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 15:32:30 -0400
Date: Fri, 11 Apr 2003 21:54:19 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: build breaks with UML patch
Message-ID: <20030411195419.GH25862@wind.cocodriloo.com>
References: <20030411213443.A35199@freebsdcluster.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411213443.A35199@freebsdcluster.dk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 09:34:43PM +0200, Vikram Rangnekar wrote:
> 
> arch/i386/kernel/sys_i386.c: In function `do_mmap2':
> arch/i386/kernel/sys_i386.c:59: warning: passing arg 1 of `do_mmap_pgoff'
> from incompatible pointertype
> arch/i386/kernel/sys_i386.c:59: warning: passing arg 2 of `do_mmap_pgoff'
> makes pointer from integer without a cast
> arch/i386/kernel/sys_i386.c:59: too few arguments to function `do_mmap_pgoff'
> make[1]: *** [arch/i386/kernel/sys_i386.o] Error 1
> make: *** [arch/i386/kernel] Error 2
> 
> When i try to make the 2.5.67 kernel with the uml-patch-2.5.67-1  
> 
> regards
> Vikram (http://www.vicramresearch.com)

Did you remember to do the ARCH=um thing everywhere?

ie: make ARCH=um menuconfig
    make ARCH=um linux

I missed it a few times when starting with uml :)

