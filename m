Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTJXTQl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 15:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTJXTQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 15:16:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:55439 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262522AbTJXTQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 15:16:39 -0400
Date: Fri, 24 Oct 2003 12:14:26 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Giuseppe <gdm84@vodafone.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can't compile udf
Message-Id: <20031024121426.12872b42.rddunlap@osdl.org>
In-Reply-To: <200310241256.42888.gdm84@vodafone.it>
References: <200310241256.42888.gdm84@vodafone.it>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Oct 2003 12:56:42 +0000 Giuseppe <gdm84@vodafone.it> wrote:

| I can't compile udf filesystem support with 2.6-test8 (i compiled it in 
| test6); this is what i get:
| 
| CC      fs/udf/super.o
| fs/udf/super.c: In function `udf_parse_options':
| fs/udf/super.c:327: `opt' undeclared (first use in this function)
| fs/udf/super.c:327: (Each undeclared identifier is reported only once
| fs/udf/super.c:327: for each function it appears in.)
| fs/udf/super.c:332: `val' undeclared (first use in this function)
| fs/udf/super.c:310: warning: unused variable `p'
| fs/udf/super.c:311: warning: unused variable `option'
| fs/udf/udf_i.h: At top level:
| fs/udf/super.c:282: warning: `tokens' defined but not used
| make[2]: *** [fs/udf/super.o] Error 1
| 
| I tried to compile it as a module and inside the kernel too. Please help me!

It looks like you have a confuzed source file.  Did you download the
kernel tarball or apply bk patches or apply cvs patches or what?

These errors make no sense for 2.6.0-test8.  The messages are not
correct for that kernel version.
Also, I have built it successfully.

If you continue to have these errors after checking the source file,
please send me your .config file.
Maybe compare your fs/udf/super.c file to the one here:
http://linus.bkbits.net:8080/linux-2.5/anno/fs/udf/super.c@1.37?nav=index.html|src/|src/fs|src/fs/udf


--
~Randy
