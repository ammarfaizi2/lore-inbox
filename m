Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261623AbSJYV4o>; Fri, 25 Oct 2002 17:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSJYV4o>; Fri, 25 Oct 2002 17:56:44 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:35565 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id <S261623AbSJYV4k>; Fri, 25 Oct 2002 17:56:40 -0400
Message-ID: <ApOnXDAL8bu9EwOR@n-cantrell.demon.co.uk>
Date: Fri, 25 Oct 2002 23:00:43 +0100
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mike Galbraith <EFAULT@gmx.de>, Thomas Molina <tmolina@cox.net>,
       linux-kernel@vger.kernel.org
From: robert w hall <bobh@n-cantrell.demon.co.uk>
Subject: Re: loadlin with 2.5.?? kernels
References: <5.1.0.14.2.20021020192952.00b95e80@pop.gmx.net>
 <5.1.0.14.2.20021021192410.00b4ffb8@pop.gmx.net>
 <m18z0os1iz.fsf@frodo.biederman.org> <007501c27b37$144cf240$6400a8c0@mikeg>
 <m1bs5in1zh.fsf@frodo.biederman.org>
In-Reply-To: <m1bs5in1zh.fsf@frodo.biederman.org>
MIME-Version: 1.0
X-Mailer: Turnpike Integrated Version 4.02 U <ZNyPpF8T4habUIG8OkVoLRXKJZ>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

which version of loadlin does this patch?
Hans Lermen changed the gdt structure in version 1.6b to enable it to
boot a win4lin-enabled kernel - he also changed things recently (1.6c)
to boot kernels of between 0.5 &1.5Mb compressed.

(IF I sat down for half an hour I could comment better.. but you
probably know the answer straight-off anyway :-))
Bob Hall


In article <m1bs5in1zh.fsf@frodo.biederman.org>, Eric W. Biederman
<ebiederm@xmission.com> writes
>"Mike Galbraith" <EFAULT@gmx.de> writes:
>
>> (sorry, I have to use this pos at work)
>> 
>> Yes.  .31 exploded on me after boot, but did not do the violent reboot
>> during boot.
>
>Earlier you had said it was .38 or so where the failures kicked in,
>so I figured it was some other problem.
> 
>> > If it is really the gdt I have some old patches that roughly do the
>> > right thing, and I just need to dust them off.
>> 
>> You dust them off, and I'll be more than happy to test them.  I keep
>> entirely too many kernels resident to want to use lilo.
>
>Here you are.
>The following patch cleans up and removes unnecessary dependencies from
>the x86 boot path.
> 
>> (kexec/bootimg wonderfulness solves my problem too.  boot into a stable
>> kernel, instant reboot into any one I want.  gimme gimme gimme:)
>
>It is getting there...
>I just need to find a formula that makes the linux kernel boot reliably.
>
>
>[ A MIME text / plain part was included here. ]
>
>
>Eric

-- 
robert w hall
