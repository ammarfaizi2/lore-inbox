Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271849AbRICWwU>; Mon, 3 Sep 2001 18:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271852AbRICWwL>; Mon, 3 Sep 2001 18:52:11 -0400
Received: from web10404.mail.yahoo.com ([216.136.130.96]:65035 "HELO
	web10404.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271849AbRICWvU>; Mon, 3 Sep 2001 18:51:20 -0400
Message-ID: <20010903225140.13484.qmail@web10404.mail.yahoo.com>
Date: Tue, 4 Sep 2001 08:51:40 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: boot problems with older machines, kernels 2.4.x
To: Thomas Ackermann <atze-lists@ewave.at>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3B938B06.E38D36A9@ewave.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Thomas Ackermann <atze-lists@ewave.at> wrote: >
Steve Kieu schrieb:
> 
> > strange! I use a rather old 486 20M ram here and
> no
> > problem.
> 
> indeed is is quite strange, if i compile that kernel
> on the 486 the machine
> works,
> only doesn`t work when i untar the system built on
> the k7 onto the 486...
> something in the system has to be wrong, maybe libs
> i think, but don't have a
> clue what it could be..
> not even a init startup message..

I once have the same problem with 2.2.19 in slackware,
thing is, even I chose to make for 486 the kernel
still refuses to run on 486 but run on the 686 (the
machine I compile. So I edit the Make file and add to
the C flags this  -mcpu=i686 -march=i486 to force it
compile for the march=i486. It works.

I am not sure at this time about my glibc, may be it
was already the new compiled one for 686 ; Let me test
today. that is compile kernel for 486 but the library
all built for 686 and see if it works. Theoreticlly if
the kernel is statically linked with libc, it wont
work  too. Am I right?

Regard






 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

=====
S.KIEU

http://travel.yahoo.com.au - Yahoo! Travel
- Got Itchy feet? Get inspired!
