Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265579AbUAGQtl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 11:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265535AbUAGQtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 11:49:41 -0500
Received: from iua-mail.upf.es ([193.145.55.10]:63110 "EHLO iua-mail.upf.es")
	by vger.kernel.org with ESMTP id S265579AbUAGQth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 11:49:37 -0500
Date: Wed, 7 Jan 2004 17:49:32 +0100
From: Maarten de Boer <mdeboer@iua.upf.es>
To: bug-glibc@gnu.org, linux-kernel@vger.kernel.org, gdb@sources.redhat.com
Subject: gdb problem with kernel 2.6.0 and pthreads
Message-Id: <20040107174932.7d7b9542.mdeboer@iua.upf.es>
Organization: IUA
X-Mailer: Sylpheed version 0.9.5-gtk2-20030906 (GTK+ 2.2.4; i386-pc-linux-gnu)
X-Face: #AF_uwd1lP*AOzp4)IlS4<F~{kOi>jBI4){\,aLiwl<~_}TN7\d_2r*/!ZEGf3sX/uirHf)p]E7b@tB?[q$8M#a}Q,)H(Rb&'+9)R^TT5YOTulm!tdEY~>_=`v>/(m)Go
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact postmaster@iua.upf.es for more information
X-MTG-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-3.101,
	required 5, BAYES_20)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry for cross-posting, but I have a problem that I am not sure whom
to address... Google did not reveal anything helpfull.

I resently moved to kernel 2.6.0 (on Debian Sarge), and while everything
seems to work just fine, to my surprise gdb now fails to debug
executables that are linked against pthread:

GNU gdb 5.3-debian
[snip]
This GDB was configured as "i386-linux"...
(gdb) b main
Breakpoint 1 at 0x80483a4: file foo.c, line 3.
(gdb) r
Starting program: /root/a.out
Error while reading shared library symbols:
Cannot find new threads: capability not available
Cannot find user-level thread for LWP 714: capability not available

With kernel 2.4.22 this problem did not occur. Do you have any idea what
may have caused this problem, and how to solve it? If I can provide you
with any information that could be helpfull, please let me know.

Kind regards,

Maarten

gcc version 3.3.2 (Debian)
GNU gdb 5.3-debian
GNU libc 2.3.2


