Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272933AbTG3PER (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 11:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272936AbTG3PER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 11:04:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:3296 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272933AbTG3PEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 11:04:15 -0400
Date: Wed, 30 Jul 2003 08:01:15 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Studying MTD <studying_mtd@yahoo.com>
Cc: agoddard@purdue.edu, joshk@triplehelix.org, linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-test1 : modules not working
Message-Id: <20030730080115.28fd5d4f.rddunlap@osdl.org>
In-Reply-To: <20030730073441.61933.qmail@web20506.mail.yahoo.com>
References: <Pine.LNX.4.56.0307300223300.4665@dust>
	<20030730073441.61933.qmail@web20506.mail.yahoo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003 00:34:41 -0700 (PDT) Studying MTD <studying_mtd@yahoo.com> wrote:

| I am curious that linux-2.6.0-test1 supports external
| modules yet or not ?
| 
| Thanks.
| 
| --- Alex Goddard <agoddard@purdue.edu> wrote:
| > On Tue, 29 Jul 2003, Studying MTD wrote:
| > 
| > > I tried hello world example from
| > > http://lwn.net/Articles/21817/
| > > 
| > > but i am still getting :-
| > > 
| > > #insmod hello_module.o
| > > No module found in object
| > > Error inserting 'hello_module.o': -1 Invalid
| > module
| > > format
| > 
| > [Snip]
| > 
| > 'kay.  So modules are enabled and everything.  More
| > specifically, I was 
| > after information such as the gcc options and stuff
| > you used to compile 
| > hello_module.o
| > 
| > Check the second article at that URL, and try
| > building your hello_module
| > with the basic Makefile it gives.  That uses the
| > best way for building
| > external modules.  After building your kernel that
| > way, try inserting the
| > hello_module.ko.

So you can insmod hello_module.ko successfully now?

Sure, 2.6 supports external modules (if you mean modules that are
built outside of the kernel source tree), but for now you also
need a full kernel source tree for the build system to reference.
I.e., you can't build an external module without having a full
kernel source tree installed and configured.

--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
