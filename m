Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135631AbRDXOIs>; Tue, 24 Apr 2001 10:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135632AbRDXOI3>; Tue, 24 Apr 2001 10:08:29 -0400
Received: from [203.36.158.121] ([203.36.158.121]:5248 "EHLO
	piro.kabuki.openfridge.net") by vger.kernel.org with ESMTP
	id <S135633AbRDXOIR>; Tue, 24 Apr 2001 10:08:17 -0400
Date: Wed, 25 Apr 2001 00:06:57 +1000
From: Daniel Stone <daniel@kabuki.openfridge.net>
To: imel96@trustix.co.id
Cc: Daniel Stone <daniel@kabuki.openfridge.net>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: problem found (was Re: [PATCH] Single user linux)
Message-ID: <20010425000656.C6067@piro.kabuki.openfridge.net>
Mail-Followup-To: imel96@trustix.co.id,
	Daniel Stone <daniel@kabuki.openfridge.net>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20010424233801.A6067@piro.kabuki.openfridge.net> <Pine.LNX.4.33.0104242046250.16242-100000@tessy.trustix.co.id>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0104242046250.16242-100000@tessy.trustix.co.id>; from imel96@trustix.co.id on Tue, Apr 24, 2001 at 09:04:02PM +0700
Organisation: Sadly lacking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 09:04:02PM +0700, imel96@trustix.co.id wrote:
> 
> 

What's with all these blank lines? Everywhere!

> On Tue, 24 Apr 2001, Daniel Stone wrote:
> > Aah. I see. Where was this? I never saw it.
> 
> psst, it's a proto.

Right-o. In the news, you say. Hrm.

> > That may be so, so hack up your own OS. It's a MOBILE PHONE, it needs to be
> > absolutely *rock solid*. Look at the 5110, that's just about perfect. The
> > 7110, on the other hand ...
> 
> mobile phone to you! already, people has put linux on pdas.

True, but I don't see what's so l33t about having bash on an Agenda, except
for, say, the novelty value of opening it up and writing "date" to get the
date in UNIX format, when someone asks you the time.

> > There are Linux advocates, but I'd say most of us are sane enough to use the
> > right-tool-for-the-job approach. And UNIX on a phone is pure overkill.
> 
> problem is you guys are to unix-centric, try to be user-centric a little.

We're too UNIX-centric, yet you're the one trying to put UNIX on a phone?
Come on ...

Al Viro made some excellent points there. If you want to run single-user,
hack /sbin/login. Hack /sbin/init. But it's not the kernel's job, what you
do.

> it's not like it ruins everything. that patch basically do something
> like allowing access to port <1024 to everybody, someone just need
> to bring a notebook to get passwd from nis.
> multi-user security is useless at home as physical access is there.

Well, not really, because what if I run single-user, but I also need to get
in from home? So, everyone who connects, gets in? What if I run BIND, and
forget to update before an exploit? Whoops, there goes my entire system,
exploited like that. Single-user is absolutely stupid, IMNSHO. Unless, of
course, if you're using something that will *never* be connected, like a
watch. In a rabbithole. A rabbithole which is B2 secure.

-- 
Daniel Stone
Linux Kernel Developer
daniel@kabuki.openfridge.net
