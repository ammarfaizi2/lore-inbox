Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270097AbTGPDT4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 23:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270098AbTGPDT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 23:19:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:45959 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270097AbTGPDTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 23:19:54 -0400
Message-ID: <1376.4.4.25.4.1058326481.squirrel@www.osdl.org>
Date: Tue, 15 Jul 2003 20:34:41 -0700 (PDT)
Subject: Re: modules problems with 2.6.0 (module-init-tools-0.9.12)
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <piet@www.piet.net>
In-Reply-To: <1058325093.18801.1224.camel@www.piet.net>
References: <3F147B8F.5000103@mail.usfq.edu.ec>
        <20030715152257.614d628b.rddunlap@osdl.org>
        <1058313192.21300.988.camel@www.piet.net>
        <20030716021210.56ea8360.diegocg@teleline.es>
        <1058325093.18801.1224.camel@www.piet.net>
X-Priority: 3
Importance: Normal
Cc: <diegocg@teleline.es>, <rddunlap@osdl.org>, <fsanchez@mail.usfq.edu.ec>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2003-07-15 at 17:12, Diego Calleja García wrote:
>> El 15 Jul 2003 16:53:12 -0700 Piet Delaney <piet@www.piet.net> escribió:
>>
>> > On Tue, 2003-07-15 at 15:22, Randy.Dunlap wrote:
>> >
>> > I heard that if you install the new module-init-tools package in /sbin
>> that you would be able to boot old kernels. Is that true?
>>
>> It works here.
>> i've a debian distro, i apt-get'ed module-init-tools. Man modprobe says:

I don't use the debian or RH packages.  I just download and follow
the instructions in the nice README file.  I get insmod, insmod.old,
depmod, depmod.old, etc.

>> BACKWARDS COMPATIBILITY
>>        This version of insmod is  for  kernels  2.5.48  and  above.   If
>> it detects  a kernel with support for old-style modules (for which
>> much of the work was done in userspace), it will attempt to run
>> insmod.modu- tils in its place, so it is completely transparent to
>> the user.
>>
>> diego@estel:~$ ls -l /sbin/insmod*
>> -rwxr-xr-x    1 root     root         5072 2003-06-15 12:27 /sbin/insmod
>> -rwxr-xr-x    1 root     root          359 2003-03-06 15:50
>> /sbin/insmod_ksymoops_clean -rwxr-xr-x    1 root     root        95372
>> 2003-03-06 15:50 /sbin/insmod.modutils
>
> Funny, I don't see insmod.modutils installed in /usr/local/sbin:
>
>   	ls -l /usr/local/sbin/insmod*
> 	-rwxr-xr-x    1 root     root        28834 Jul  9 14:36
> 								/usr/local/sbin/insmod
> 	-rwxr-xr-x    1 root     root       461564 Jul  9 14:36
> 								/usr/local/sbin/insmod.static
>
> I also didn't find insmod.modutils in the module-init-tools-0.9.12 src:
>    [root@www src]# find module-init-tools-0.9.12 -name "*insmod*" -print
> module-init-tools-0.9.12/doc/insmod.sgml
>    module-init-tools-0.9.12/insmod.c
>    module-init-tools-0.9.12/insmod.8
>    module-init-tools-0.9.12/.deps/insmod.Po
>    module-init-tools-0.9.12/insmod.o
>    module-init-tools-0.9.12/insmod
>    module-init-tools-0.9.12/insmod.static
>    [root@www src]#
>
>>
>>
>> Looking at the size, insmod.modutils seems the 2.4 insmod loader.
> I think I missed something.

I don't think that I have that one either.  Could be a result
of using one of the packages instead of building it from source.

~Randy



