Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbTFISSl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 14:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbTFISSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 14:18:41 -0400
Received: from wmail.atlantic.net ([209.208.0.84]:51328 "HELO
	wmail.atlantic.net") by vger.kernel.org with SMTP id S262494AbTFISSj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 14:18:39 -0400
Message-ID: <3EE4D5A5.1070303@techsource.com>
Date: Mon, 09 Jun 2003 14:44:53 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding standards.  (Was: Re: [PATCH] [2.5] Non-blocking write
 can block)
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk> <20030604065336.A7755@infradead.org> <3EDE0E85.7090601@techsource.com> <20030607001202.GB14475@kroah.com> <3EE4B4C3.80902@techsource.com> <20030609163959.GA13811@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jörn Engel wrote:
> On Mon, 9 June 2003 12:24:35 -0400, Timothy Miller wrote:
> 
>>One thing I wanted to mention, however, is that your tongue-in-cheek 
>>style doesn't help you.  Coding style is something that needs to be 
>>taken seriously when you're setting standards.
> 
> 
> Coding style is secondary.  It doesn't effect the compiled code.  That
> simple.

Agreed.

> In the case of the kernel, there is quite a bit of horrible coding
> style.  But a working device driver for some hardware is always better
> that no working device driver for some hardware, and if enforcing the
> coding style more results is scaring away some driver writers, the
> style clearly loses.

It is a trivial fact that all coding styles are completely arbitrary. 
Yes, there may be many things which are chosen because they make the 
most sense, but there are always numerous choices along the way, all of 
which would be reasonable, that have to be reduced to one.  Some 
philosophers will tell you that all of reality is completely arbitrary 
and made up; of course, they're referring to our perceptions and choices 
moreso than to, say, physics.  Well, what exemplifies arbitrary reality 
more than computer science?  Every last drop of it was invented out of 
whole cloth.  So when you think about it, the C syntax itself is 
arbitrary, and thus even moreso are the coding styles.

But we have a practical goal in mind here.  Not only does something have 
to WORK (compile to working machine code), but our grandchildren, using 
Linux 20.14.6 are going to have to be able to make sense out of what we 
wrote.  Were it not for the fact that Linux is a collaborative project, 
we would not need these standards.

So, yes, while it may seem silly to do it "just because K&R did it that 
way", it is nevertheless a reasonable (albeit arbitrary) choice to make. 
  Someone has to make the choice, enforce it, and make sure that 
everyone understands it.  If there is one style, then it will be easier 
for new people to understand it once they have read the style guide.

Still, it IS nice to have someone produce justification for their 
choices once in a while.

