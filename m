Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUAHJnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 04:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbUAHJnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 04:43:10 -0500
Received: from [61.51.122.197] ([61.51.122.197]:52987 "EHLO
	kapok.exavio.com.cn") by vger.kernel.org with ESMTP id S263937AbUAHJnH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 04:43:07 -0500
Date: Thu, 8 Jan 2004 17:45:49 +0800
From: Isaac Claymore <clay@exavio.com.cn>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] disallow modular BINFMT_ELF
Message-ID: <20040108094549.GA9225@exavio.com.cn>
Mail-Followup-To: Isaac Claymore <clay@exavio.com.cn>,
	linux-kernel@vger.kernel.org
References: <20040107194759.GC11523@fs.tum.de> <20040107235109.52abe4a2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107235109.52abe4a2.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 11:51:09PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> > with no 2.4 kernel BINFMT_ELF=m actually worked, you always get a
> > 
> >  <--  snip  -->
> > 
> >  depmod: *** Unresolved symbols in /lib/modules/2.4.25-pre4/kernel/fs/binfmt_elf.o
> >  depmod:         smp_num_siblings
> >  depmod:         put_files_struct
> >  depmod:         steal_locks
> 
> In 2.6 we gave up and made CONFIG_BINFMT_ELF a def_bool.  So people who
> want it get it statically linked.  People who are making tiny a.out systems
> set it to 'n'.

Could you please give some hint about what's hindering ELF support from
being a module?

Just curious, thanks.


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

Regards, Isaac
()  ascii ribbon campaign - against html e-mail
/\                        - against microsoft attachments
