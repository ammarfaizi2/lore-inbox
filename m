Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272832AbTG3GuR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 02:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272791AbTG3GuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 02:50:17 -0400
Received: from web20501.mail.yahoo.com ([216.136.226.136]:59699 "HELO
	web20501.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272913AbTG3GuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 02:50:09 -0400
Message-ID: <20030730065007.93696.qmail@web20501.mail.yahoo.com>
Date: Tue, 29 Jul 2003 23:50:07 -0700 (PDT)
From: Studying MTD <studying_mtd@yahoo.com>
Subject: Re: linux-2.6.0-test1 : modules not working
To: Alex Goddard <agoddard@purdue.edu>
Cc: Joshua Kwan <joshk@triplehelix.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0307300120200.3692@dust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried hello world example from
http://lwn.net/Articles/21817/

but i am still getting :-

#insmod hello_module.o
No module found in object
Error inserting 'hello_module.o': -1 Invalid module
format

my config is :-
/*
 * General setup
 */
#undef CONFIG_SWAP
#define CONFIG_SYSVIPC 1
#undef CONFIG_BSD_PROCESS_ACCT
#define CONFIG_SYSCTL 1
#define CONFIG_LOG_BUF_SHIFT 14
#undef CONFIG_EMBEDDED
#define CONFIG_KALLSYMS 1
#define CONFIG_FUTEX 1
#define CONFIG_EPOLL 1

/*
 * Loadable module support
 */
#define CONFIG_MODULES 1
#define CONFIG_MODULE_UNLOAD 1
#define CONFIG_OBSOLETE_MODPARM 1
#define CONFIG_KMOD 1

How to fix this problem.

thanks.

--- Alex Goddard <agoddard@purdue.edu> wrote:
> On Tue, 29 Jul 2003, Studying MTD wrote:
> 
> > module-init-tools-0.9.12 is giving :-
> > 
> > #insmod hello_module.o
> > No module found in object
> > Error inserting 'hello_module.o': -1 Invalid
> module
> > format
> > 
> > #file hello_module.o
> > hello_module.o: ELF 32-bit LSB relocatable,
> Hitachi
> > SH, version 1 MathCoPro/FPU/MAU Required (SYSV),
> not
> > stripped
> > 
> > how to fix this.
> 
> Some information on how you built hello_module.o
> would be nice.  You might
> also want to look at the first two (at least)
> articles here:  
> http://lwn.net/Articles/driver-porting/
> 
> -- 
> Alex Goddard
> agoddard@purdue.edu
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
