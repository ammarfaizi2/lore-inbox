Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265406AbUAHQ2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265549AbUAHQ1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:27:06 -0500
Received: from iua-mail.upf.es ([193.145.55.10]:28862 "EHLO iua-mail.upf.es")
	by vger.kernel.org with ESMTP id S265406AbUAHQ0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 11:26:10 -0500
Date: Thu, 8 Jan 2004 16:44:47 +0000 (UTC)
From: Maarten de Boer <mdeboer@iua.upf.es>
X-X-Sender: mdeboer@iua-mail.upf.es
To: bug-glibc@gnu.org, <linux-kernel@vger.kernel.org>,
       <gdb@sources.redhat.com>
Subject: Re: gdb problem with kernel 2.6.0 and pthreads
In-Reply-To: <20040107174932.7d7b9542.mdeboer@iua.upf.es>
Message-ID: <Pine.LNX.4.44.0401081643400.1419-100000@iua-mail.upf.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner-Information: Please contact postmaster@iua.upf.es for more information
X-MTG-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-5.801,
	required 5, BAYES_10)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As suggested by several people, moving to gdb 6.0 solves the problem,
so for the record.

Thanks,

Maarten

> Hello,
>
> Sorry for cross-posting, but I have a problem that I am not sure whom
> to address... Google did not reveal anything helpfull.
>
> I resently moved to kernel 2.6.0 (on Debian Sarge), and while everything
> seems to work just fine, to my surprise gdb now fails to debug
> executables that are linked against pthread:
>
> GNU gdb 5.3-debian
> [snip]
> This GDB was configured as "i386-linux"...
> (gdb) b main
> Breakpoint 1 at 0x80483a4: file foo.c, line 3.
> (gdb) r
> Starting program: /root/a.out
> Error while reading shared library symbols:
> Cannot find new threads: capability not available
> Cannot find user-level thread for LWP 714: capability not available
>
> With kernel 2.4.22 this problem did not occur. Do you have any idea what
> may have caused this problem, and how to solve it? If I can provide you
> with any information that could be helpfull, please let me know.
>
> Kind regards,
>
> Maarten
>
> gcc version 3.3.2 (Debian)
> GNU gdb 5.3-debian
> GNU libc 2.3.2
>
>
>

