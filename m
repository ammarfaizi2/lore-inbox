Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266502AbUGUOBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266502AbUGUOBl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 10:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUGUOBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 10:01:31 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:58816 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S266435AbUGUOB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 10:01:28 -0400
In-Reply-To: <313680C9A886D511A06000204840E1CF08F43047@whq-msgusr-02.pit.comms.marconi.com>
References: <313680C9A886D511A06000204840E1CF08F43047@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6529D472-DB1E-11D8-9613-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
       crossgcc <crossgcc@sources.redhat.com>,
       "'bertrand marquis'" <bertrand_marquis@yahoo.fr>,
       "'trevor_scroggins@hotmail.com'" <trevor_scroggins@hotmail.com>,
       "'Dan Kegel'" <dank@kegel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: missing elf.h (for mk_elfconfig.c)  while  building zImage for PPC on Intel platform (windows XP) using cygwin
Date: Wed, 21 Jul 2004 09:01:00 -0500
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 21, 2004, at 6:28 AM, Povolotsky, Alexander wrote:
>
> Now I am facing the next problem: missing elf.h (for mk_elfconfig.c) 
> while
> building zImage for PPC on Intel platform (windows XP) using cygwin.
>
> $ make zImage
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/split-include
>   HOSTCC  scripts/basic/docproc
>   HOSTCC  scripts/conmakehash
>   HOSTCC  scripts/kallsyms
>   CC      scripts/empty.o
>   HOSTCC  scripts/mk_elfconfig
> scripts/mk_elfconfig.c:4:17: elf.h: No such file or directory

I also saw this problem when trying to cross-build from Mac OS X a 
while ago. A couple build tools assume the existence of 
/usr/include/elf.h ... (adding LKML to cc)

-- 
Hollis Blanchard
IBM Linux Technology Center

