Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284010AbRLMOkm>; Thu, 13 Dec 2001 09:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284068AbRLMOkc>; Thu, 13 Dec 2001 09:40:32 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:15170 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S284010AbRLMOkT>; Thu, 13 Dec 2001 09:40:19 -0500
Date: Thu, 13 Dec 2001 08:40:18 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200112131440.IAA49406@tomcat.admin.navo.hpc.mil>
To: pozsy@sch.bme.hu, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where does 'vmlinuz' come from?
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan <jjs@lexus.com>
> Hi all,
> 
> This is not a bugreport, but a simple question: :)
> where does the term vmlinuz come from?

It is partly historical:

Original boot on PDP-11, the kernel was kept in the file /unix (date was mid
to late 1970s)

When virtual memory was added it was changed to /vmunix (early 80s I think)
to distinguish the difference on those systems that could do both (Mid 80s
I had a Motorola 68020 that still used /unix since the VM hadn't been finished
yet).

Then on to Linux, which added compression. Since the name UNIX (in all it's
forms) was copyrighted and couldn't be used to name the system the OS became
linux, and, following the progression, vmlinux hence - with compressed files
having a Z or gz extension - vmlinuz

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
