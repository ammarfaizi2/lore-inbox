Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbSLJXFQ>; Tue, 10 Dec 2002 18:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266805AbSLJXFQ>; Tue, 10 Dec 2002 18:05:16 -0500
Received: from dp.samba.org ([66.70.73.150]:52410 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266795AbSLJXFP>;
	Tue, 10 Dec 2002 18:05:15 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module-init-tools 0.9.3 -- "missing" issue 
In-reply-to: Your message of "Tue, 10 Dec 2002 07:44:33 -0800."
             <2105495.1039535073217.JavaMail.nobody@web55.us.oracle.com> 
Date: Wed, 11 Dec 2002 09:59:56 +1100
Message-Id: <20021210231301.1301B2C078@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <2105495.1039535073217.JavaMail.nobody@web55.us.oracle.com> you writ
e:
> As per the README...
> 
> [asuardi@dolphin module-init-tools-0.9.3]$ aclocal
> [asuardi@dolphin module-init-tools-0.9.3]$ automake --add-missing --copy
> Makefile.am: installing `./depcomp'
> [asuardi@dolphin module-init-tools-0.9.3]$ autoconf
> [asuardi@dolphin module-init-tools-0.9.3]$ ./configure --prefix=/
> checking build system type... i686-pc-linux-gnu
> checking host system type... i686-pc-linux-gnu
> checking target system type... i686-pc-linux-gnu
> checking for a BSD-compatible install... /usr/bin/install -c
> checking whether build environment is sane... yes
> /download/kernel/v2.5/module-init-tools-0.9.3/missing: Unknown `--run' option
> Try `/download/kernel/v2.5/module-init-tools-0.9.3/missing --help' for more i
nformation

Hmm, you don't need to run aclocal, automake and autoconf if you don't
alter the sources.  I have altered the README to put that at the
bottom:

5) If you want to hack on the source:
	aclocal && automake --add-missing --copy && autoconf

Thanks for the report!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
