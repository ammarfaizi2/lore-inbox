Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261569AbTCOVVL>; Sat, 15 Mar 2003 16:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbTCOVVL>; Sat, 15 Mar 2003 16:21:11 -0500
Received: from air-2.osdl.org ([65.172.181.6]:29634 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261569AbTCOVVJ>;
	Sat, 15 Mar 2003 16:21:09 -0500
Message-ID: <34070.4.64.238.61.1047763919.squirrel@www.osdl.org>
Date: Sat, 15 Mar 2003 13:31:59 -0800 (PST)
Subject: Re: [PATCH] update filesystems config. menu
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <azarah@gentoo.org>
In-Reply-To: <20030315211151.40f1cf84.azarah@gentoo.org>
References: <200303150920.h2F9KGm16328@mako.theneteffect.com>
        <1047720287.3505.146.camel@workshop.saharact.lan>
        <33707.4.64.238.61.1047748124.squirrel@www.osdl.org>
        <20030315211151.40f1cf84.azarah@gentoo.org>
X-Priority: 3
Importance: Normal
Cc: <rddunlap@osdl.org>, <mitch@theneteffect.com>, <davej@codemonkey.org.uk>,
       <Randy.Dunlap@mako.theneteffect.com>, <randy.dunlap@verizon.net>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 15 Mar 2003 09:08:44 -0800 (PST)
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
>> I'm having trouble decoding...
>> What is it that "should be safest for most people"?
>> Are you suggesting any changes here?
>>
>> And some of us don't use fs modules, just build what we need into the
>> kernel.  Do you know of any problems with doing this (related to ext2/ext3
>> for example)?
>>
>
> I was just saying that recommending it (ext2) compiled into the kernel and
> not a module should be the safe route for newbies to kernel
> compiles.

Thanks for the clarification.

> Those of us that have build a few to feel comfortable with it, will know to
> compile the fs of our / partition into the kernel.
>
> Except if ext2 is not the most commonly used fs anymore.  I guess a 'cool'
> feature could be if the make system could 'detect' what your current root is
> and warn if you do not have that compiled into your kernel, but I do not
> know the limitations of it (the make system).
>
> Then on the other hand, would above be confusing if its a kernel
> compiled for another box ?

Yes, I'd say so, although the message could say something like:
  Kernel does not include a filesystem for / on this computer.
And would it also have to check the capabilities of what's in the
initrd?  (not that I'm advocating any of this)

~Randy



