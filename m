Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbRBMW5l>; Tue, 13 Feb 2001 17:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129617AbRBMW5b>; Tue, 13 Feb 2001 17:57:31 -0500
Received: from mnh-1-21.mv.com ([207.22.10.53]:53514 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S129495AbRBMW5V>;
	Tue, 13 Feb 2001 17:57:21 -0500
Message-Id: <200102140007.TAA04135@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: LA Walsh <law@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: To Linus: kdb in 2.4? 
In-Reply-To: Your message of "Tue, 13 Feb 2001 13:53:52 PST."
             <3A89ACF0.142CB71B@sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Feb 2001 19:07:59 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

law@sgi.com said:
> I'm wondering about the possibility of re-examining the idea of a
> kernel debugger option distributed with 2.4.   

First off, I'd like to say that I'm highly sympathetic to this, assuming that 
a kernel debugger doesn't change the kernel's behavior.

However, 

> I'm thinking that it could be a great teaching tool to break and
> examine structures, variables, process states, as well as an aid to
> people who may not have a grasp of the entire kernel but need to write
> device drivers. 

you might look at UML (http://user-mode-linux.sourceforge.net) for this.  A 
number of kernel hackers are very successfully using UML for doing filesystem 
and mm development and debugging.  With some help from the host, it's also 
possible to do driver development under UML.

I also know of a number of people using UML to further their education by 
using it to poke around a running kernel.

> Certainly Buddha doesn't need to know how to read to know his own
> writings -- and certainly, if everyone meditates and 'evolves' to
> their Buddha nature, they wouldn't need to read the texts or recognize
> the letters either.   

So, if you can't convince Buddha of the wisdom of your arguments (or even if 
you can) check out UML.  It makes a perfectly good kernel debugger available, 
and it's a lot easier to deal with than a native kernel.

				Jeff


