Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262839AbTC1JOb>; Fri, 28 Mar 2003 04:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262840AbTC1JOa>; Fri, 28 Mar 2003 04:14:30 -0500
Received: from ccnetbkup.hku.hk ([147.8.2.96]:27610 "EHLO mail2.hku.hk")
	by vger.kernel.org with ESMTP id <S262839AbTC1JO3>;
	Fri, 28 Mar 2003 04:14:29 -0500
Message-ID: <00d801c2f50b$f3f9e080$18f90893@george804>
From: "George Chang" <h9916628@hkusua.hku.hk>
To: <linux-kernel@vger.kernel.org>
References: <3E84607C@webmaila.hku.hk> <005001c2f46a$7618e950$f40101c1@mopcXP>
Subject: Re: Read and write by a module
Date: Fri, 28 Mar 2003 17:25:17 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-MailScanner: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have read the book but it seems not useful for file operation in kernel
mdoule. I have completed a read and write part for module. But dont know why
the system will hang up when reading  and writing the file for more than 3
times.

Could anyone tell me the procedures for file operation in kernel, e.g. do I
need spin_locks() first ?
I think another problem is the declaration of char array. I use char *temp=
kmalloc(50, GFP_KERNEL), is it correct? I guess the hang-up problem may be
due to the null pointer dereference .

Anyone knows about installation and configuration of SGI KDB kernel
debugger?

Thanks

George

----- Original Message -----
From: "Andre Heine" <linux-experience@gmx.net>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, March 27, 2003 10:09 PM
Subject: Re: Read and write by a module


> Hi,
>
> From: "h9916628" <h9916628@hkusua.hku.hk>
> > Please help! I have to read and write cotents from a file by a module.
Could
> > anyone tell me the procedures or advise me? This is very urgent to me.
Thanks
>
> On www.oreilly.com is an "free Book", called Linux Device Driver, Author
A.Rubini.
>
> This book describe the basic about writing modules & systemcalls ...
>
> There also many tutorial in the web
>
> Bye
>
> Andre
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


