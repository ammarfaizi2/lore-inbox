Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272258AbTG3WIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272264AbTG3WIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:08:11 -0400
Received: from web20512.mail.yahoo.com ([216.136.175.20]:9610 "HELO
	web20512.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272258AbTG3WIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:08:05 -0400
Message-ID: <20030730220804.27148.qmail@web20512.mail.yahoo.com>
Date: Wed, 30 Jul 2003 15:08:04 -0700 (PDT)
From: Studying MTD <studying_mtd@yahoo.com>
Subject: Re: linux-2.6.0-test1 : modules not working
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: agoddard@purdue.edu, joshk@triplehelix.org, linux-kernel@vger.kernel.org
In-Reply-To: <20030730080115.28fd5d4f.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your help, I am able to insert the module
but not able to remove it.

#insmod modtest.ko
: module licence 'unspecified' taints kernel.
Hello World
#lsmod
Module                 Size  Used by
896                       0  - Live 0xc0102000

#rmmod modtest
Can't open 'modtest' : No such file or directory

#rmmod 896
Can't open '896' : No such file or directory

Please help me to rmmod it.

Thanks.

--- "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> On Wed, 30 Jul 2003 00:34:41 -0700 (PDT) Studying
> MTD <studying_mtd@yahoo.com> wrote:
> 
> | I am curious that linux-2.6.0-test1 supports
> external
> | modules yet or not ?
> | 
> | Thanks.
> | 
> | --- Alex Goddard <agoddard@purdue.edu> wrote:
> | > On Tue, 29 Jul 2003, Studying MTD wrote:
> | > 
> | > > I tried hello world example from
> | > > http://lwn.net/Articles/21817/
> | > > 
> | > > but i am still getting :-
> | > > 
> | > > #insmod hello_module.o
> | > > No module found in object
> | > > Error inserting 'hello_module.o': -1 Invalid
> | > module
> | > > format
> | > 
> | > [Snip]
> | > 
> | > 'kay.  So modules are enabled and everything. 
> More
> | > specifically, I was 
> | > after information such as the gcc options and
> stuff
> | > you used to compile 
> | > hello_module.o
> | > 
> | > Check the second article at that URL, and try
> | > building your hello_module
> | > with the basic Makefile it gives.  That uses the
> | > best way for building
> | > external modules.  After building your kernel
> that
> | > way, try inserting the
> | > hello_module.ko.
> 
> So you can insmod hello_module.ko successfully now?
> 
> Sure, 2.6 supports external modules (if you mean
> modules that are
> built outside of the kernel source tree), but for
> now you also
> need a full kernel source tree for the build system
> to reference.
> I.e., you can't build an external module without
> having a full
> kernel source tree installed and configured.
> 
> --
> ~Randy
> | http://developer.osdl.org/rddunlap/ |
> http://www.xenotime.net/linux/ |
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
