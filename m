Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266200AbTAHLPA>; Wed, 8 Jan 2003 06:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266203AbTAHLPA>; Wed, 8 Jan 2003 06:15:00 -0500
Received: from hacksaw.org ([216.41.5.170]:36801 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S266200AbTAHLO7>; Wed, 8 Jan 2003 06:14:59 -0500
Message-Id: <200301081123.h08BNQiO000383@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.5 08/15/2002 with nmh-1.0.4
To: Nils Petter Vaskinn <nils.petter.vaskinn@itsopen.net>
cc: rms@gnu.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: OT Naming. was: Re: Why is Nvidia given GPL'd code to use in 
 closed source drivers?
In-reply-to: Your message of "08 Jan 2003 10:04:39 +0100."
             <1042016680.1714.16.camel@station3> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Jan 2003 06:23:26 -0500
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The "GNU/Linux" vs "Linux" argument is a political one, not a practical
>one, don't try to disguise it.

I used to agree with this, and as far as politics, I do. However, a practical 
reason to call it GNU/Linux just occurred to me: the ABI.

Linux is a kernel. It runs on a variety of platforms. You certainly must 
differentiate between a program for Linux on StrongARM and one for Linux on 
x86. To use a kernel one makes calls into it via a system call mechanism. In 
the case of the vast majority of Linux installations, that is done via glibc. 
Not for kicks is that 'g' there.

A system with a linux kernel using a different API will likely have a 
different ABI for it's programs.

This will need to be accounted for at some point. Forget all the tools for the 
moment, and just think about what makes the program ABI.

Is there any vendor out there now who's shipping something other than glibc 
with their Linux distribution? I bet there is someone, probably in the 
embedded market.

Of course, I bow to human nature. People will continue to make references to 
Linux meaning the OS, and never mention the qualifiers, until it becomes an 
issue.

Here's to looking forward to the day when it does. :-)


-- 
We begin again, constantly.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


