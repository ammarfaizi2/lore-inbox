Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269686AbRHIGSC>; Thu, 9 Aug 2001 02:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269687AbRHIGRx>; Thu, 9 Aug 2001 02:17:53 -0400
Received: from palrel1.hp.com ([156.153.255.242]:55013 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S269686AbRHIGRk>;
	Thu, 9 Aug 2001 02:17:40 -0400
Message-ID: <3B722A4B.B139BCC2@india.hp.com>
Date: Thu, 09 Aug 2001 11:44:35 +0530
From: Milind <dmilind@india.hp.com>
Organization: HP
X-Mailer: Mozilla 4.7 [en] (X11; I; HP-UX B.10.20 9000/712)
X-Accept-Language: en
MIME-Version: 1.0
To: Sarada prasanna <csaradap@mihy.mot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Makefile or Shell file
In-Reply-To: <C1590740235CD211BA5600A0C9E1F6FF0260226B@hydmail.mihy.mot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think any of them will help you out , but based on your requisites.

If you have tasks that are independent , then you can go for shell file and
execute
it using sh(sh-posix) or ksh(korn shell) or bash/ksh if you are using linux.

Makefile is generally used for a sequence of dependent tasks, normally the
makefile has a hierarchical structure, eg

target (exe): <a.o> <b.o>
                     <other dependencies like .a , .h  files>

a.o : cc  <options> a.c
        <other dependencies like .h , .a files>
b.o:  cc <options> b.c
        .
        .
        .

So its really question of nature of tasks.


Sarada prasanna wrote:

> I have a process here before which I have to complete  some pre required
> tasks ...Right now I do them manually.....i want an automated process that
> will do them automatically....
> Is there any way.....
>   will makefile or shell file come to my rescue....
>
>                                                 cspn
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

