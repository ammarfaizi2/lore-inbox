Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261653AbRESFrg>; Sat, 19 May 2001 01:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261657AbRESFr1>; Sat, 19 May 2001 01:47:27 -0400
Received: from james.kalifornia.com ([208.179.59.2]:63068 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S261653AbRESFrP>; Sat, 19 May 2001 01:47:15 -0400
Message-ID: <3B06082E.9090708@kalifornia.com>
Date: Fri, 18 May 2001 22:44:14 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
To: Charles Cazabon <linux-kernel@discworld.dyndns.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: CML2 design philosophy heads-up
In-Reply-To: <20010518034307.A10784@thyrsus.com> <E150fV9-0006q1-00@the-village.bc.nu> <20010518105353.A13684@thyrsus.com> <3B053B9B.23286E6C@redhat.com> <20010518112625.A14309@thyrsus.com> <20010518093414.A21164@qcc.sk.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Cazabon wrote:

>Eric S. Raymond <esr@thyrsus.com> wrote:
>
>>Arjan van de Ven <arjanv@redhat.com>:
>>
>>>Aunt Tillie doesn't even know what a kernel is, nor does she want
>>>to. I think it's fair to assume that people who configure and
>>>compile their own kernel (as opposed to using the distribution
>>>supplied ones) know what they are doing.
>>>
>>I'd like to break these assumptions.  Or at the very least see how far
>>they can be bent.  I know this sounds crazy to a lot of hackers, but 
>>I think there's a certain amount of unhelpful elitism and self-puffery
>>in the "kernels are hard to configure and they *should* be hard to 
>>configure* attitude.  Let's give Aunt Tillie a chance to surprise us.
>>
>
>Whether this is desirable or not is debatable.  The big question is:  why on
>earth would Aunt Tillie _want_ to compile a kernel at all, let alone
>re-configure one?  If she's using Linux, she's installing her distribution's
>pre-compiled kernel, and has no need for anything else.
>
>Simplifying the configuration interface so that "anyone" can use it seems like
>a waste of effort.  If there's an interested novice out there who wants to
>learn how to configure a kernel, they'll be sufficiently interested to invest
>an hour or two in learning how the whole process works.  Make it as simple as
>it needs to be, and no simpler.
>
>Charles
>
Because, for example, a kernel compile can be a part of the standard 
install now, and you will end up with a kernel built specifically for 
your machine that doesn't print 50 initialization failed messages on boot.

Libranet (Debian offshoot) does that already.  It is the only distro 
that I know of that does this.  This also makes it about a thousand 
times easier for distributions.  They don't have to write huge (have you 
ever looked at Redhat scripts??) init scripts to cover every single 
possibility and load any module you might need.  It's built into the 
kernel, the way it should be!

And you can also now run a kernel built for your shiny new Athlon, not 
the old piece of shit that was hot stuff in '92.

-b

-- 
 "One trend that bothers me is the glorification of
stupidity, that the media is reassuring people it's 
alright not to know anything. That to me is far more 
dangerous than a little pornography on the Internet." 
  - Carl Sagan



