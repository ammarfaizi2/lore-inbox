Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbUCGU7g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 15:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbUCGU7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 15:59:35 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:33187 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262333AbUCGU7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 15:59:34 -0500
Date: Mon, 08 Mar 2004 04:58:52 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "David Weinehall" <tao@acc.umu.se>,
       "Rene Herman" <rene.herman@keyaccess.nl>
Subject: Re: Linux 2.4.26-pre2
Cc: "Horst von Brand" <vonbrand@inf.utfsm.cl>,
       "Eyal Lebedinsky" <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org
References: <404AB6C7.7010803@eyal.emu.id.au> <200403071619.i27GJkOZ003480@eeyore.valparaiso.cl> <20040307192504.GS19111@khan.acc.umu.se> <404B7D8D.1060801@keyaccess.nl> <20040307200509.GT19111@khan.acc.umu.se>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr4ie8ex74evsfm@smtp.pacific.net.th>
In-Reply-To: <20040307200509.GT19111@khan.acc.umu.se>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Mar 2004 21:05:09 +0100, David Weinehall <tao@acc.umu.se> wrote:

> On Sun, Mar 07, 2004 at 08:52:45PM +0100, Rene Herman wrote:
>> David Weinehall wrote:
>>
>> >>>In standard C we declare all variables at the top of a function. While
>> >>>some compilers allow extension, it is not a good idea to get used to
>> >>>them if we want portable code.
>> >>
>> >>Oh, come on. This is _kernel_ code, it won't ever be compiled with
>> >>anything
>> >>not GCC-compatible.
>> >
>> >Ugly warts don't become any less ugly just because gcc accepts them...
>>
>> Mixing code and declarations is also c99. For (a sane) gcc specifically,
>> you have to tell it -std=c89 -pedantic to have it even complain.
>
> Ok, didn't know that.  Still doesn't make it any less ugly, though.
> There are quite a lot of things that a valid in C.  That doesn't mean
> they should be used...

C99 is C++ish. I have my experience with these methods after following
the PopularCppWays for some time. HellIsThisCrap which I wrote a pain
to maintain...

When a function is short and concise, there is no need to worry about
the few variables at the top.

Regards
Michael


