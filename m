Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291054AbSAaM4r>; Thu, 31 Jan 2002 07:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291056AbSAaM4i>; Thu, 31 Jan 2002 07:56:38 -0500
Received: from [195.63.194.11] ([195.63.194.11]:48395 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291054AbSAaM40>; Thu, 31 Jan 2002 07:56:26 -0500
Message-ID: <3C593EEC.3000907@evision-ventures.com>
Date: Thu, 31 Jan 2002 13:56:12 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: mingo@elte.hu
CC: David Weinehall <tao@acc.umu.se>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201311528550.9572-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>On Thu, 31 Jan 2002, David Weinehall wrote:
>
>>On Thu, Jan 31, 2002 at 03:17:52PM +0100, Ingo Molnar wrote:
>>
>>>'old' architectures do not hinder development - they are separate, and
>>>they have to update their stuff. (and i think the m68k port is used by
>>>many other people and not CS archeologists.) Old drivers are not a true
>>>problem either - if they dont compile that's the problem of the
>>>maintainer. Occasionally old drivers get zapped (mainly when there is a
>>>new replacement driver).
>>>
>>To testify that even really old hardware is used, I recently received
>>a patch for 2.0.xx to add autodetection for wd1002s-wx2 in the
>>xd.c-driver. Not particularly recent hardware, but the person who sent
>>the patch uses it. Why deny him usage of his hardware when it doesn't
>>intrude upon the rest of the codebase?
>>
>
>exactly. Cruft hanging around does hurt in the 'generic' kernel. There is
>'leaf' code where it hurts much less. Sure, we'd like to have clean code
>everywhere, and a driver with a clean and recent codebase will get more
>attention from the architecture point of view, but to the user, an
>outdated but working driver is better than no driver at all.
>
It's an incredibble bandwidth waste for 99.99% of people downolading 
2.5.xx and it *is* making architectural
changes in the kernel harder, becouse the modularisatoin of the kernel 
isn't nearly as perfect as you try
to disguise it here. Please just have a look at the consequences of the 
kdev_t changes, which where necessary
since already about 8 years. And then my these is somehow tautological 
if it doesn't apply now, it will
apply in about 4 years. At some point in time there is the need to let 
some things go - the problem
is more fundamental.


