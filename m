Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292948AbSB0V5K>; Wed, 27 Feb 2002 16:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292987AbSB0V4e>; Wed, 27 Feb 2002 16:56:34 -0500
Received: from fe040.worldonline.dk ([212.54.64.205]:8713 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S292991AbSB0Vy7>; Wed, 27 Feb 2002 16:54:59 -0500
Message-ID: <3C7D5644.1090002@dif.dk>
Date: Wed, 27 Feb 2002 22:57:24 +0100
From: Jesper Juhl <jju@dif.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: lachinois@hotmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel module ethics. 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > The company for whom I work wants to make a linux driver for some of its
 > hardware. On my side I would like the driver to be completely open 
sourced,
 > and from a customer point of view, its a big plus (a real PITA to 
maintain
 > closed sourced drivers). On the other hand, the company wants a clear 
way to
 > make "profit" from the work while still catering to it's customers 
whish to
 > recompile the driver for just about any kernel version.

 > Here is what they propose... I do not know if what they are proposing is
 > "going too far" regarding kernel module ethics, but I thought I'd ask 
the
 > question here and see what other people think.

 > The hardware needs a firmware to run. Since this firmware is under 
NDA, the
 > first compromise is to write the main part of the driver GPL but keep 
the
 > firmware of the card in binary format. The driver can then load the 
firmware
 > separately and this should not infringe on the GPL and I'm quite ok with
 > this requirement. Now the problem is that any of our competitor's 
cards will
 > work with the same closed sourced firmware and GPL engine. In pure
 > capitalist thinking, the company finds this particularly troublesome...

 > The other compromise is to write a closed source part that would not 
permit
 > the driver to work with another card supporting the same chipset. Is 
this
 > kind of practice generally accepted or is it frowned upon?

I think you'll find that a lot of people will frawn upon that practice, 
since most people are just interrested in getting support for as much 
hardware as possible, and usually considers it a good thing if one 
driver works with different hardware. But, it's your choise, and it 
would certainly be better than not releasing a driver at all if you ask 
me personally :)

 >The motive of the
 > company is quite clear. If people want to "improve" the driver, they can
 > only improve it for their hardware, not the competitors. There is 
also a big
 > marketing sales pitch that goes like "we support linux, the others
 > don&#8217;t..."

 > It's like if Nvidia did not have linux drivers and ASUS wanted to ship a
 > card with a linux driver that only works with asus cards even though 
there
 > is one from leadtek with the exact same chipset (assuming that ASUS 
cannot
 > change the internals of the card).

 > Is the second compromise just "going too far"? Is this better than 
simply
 > having a 100% closed source driver?

 From my personal poing of view, having a Linux driver available in any 
form is a lot better than not having a Linux driver at all. Ofcourse a 
100% opensource driver (including firmware) would be the best and is (I 
think) the only thing that will have a chance of being included in the 
mainline kernel

Having Open Source driver and closed firmware is ofcourse not as good, 
but still a lot better for the users, since they can recompile the 
driver for different kernels. This is what NVidia does as far as I know. 
But you should probably expect to handle all support issues and 
bug-reports yourself, since if the full source is not available you'll 
be the only one who /can/ fix problems.

A completely closed source driver is in my personal oppinion only a good 
idea if the only other option is no driver at all. The Linux kernel is a 
fast moving target, and you'd have to release a new version of your 
driver everytime something in the kernel that affects your driver 
changes.  Since the users cannot even recompile it to match a new 
kernel. Ofcourse it's better than no driver, but consider the other 
options again.

Just my personal opinion ;)


- Jesper Juhl - jju@dif.dk




