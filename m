Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267399AbUH1KGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267399AbUH1KGV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 06:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266391AbUH1KEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 06:04:23 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:21458 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267447AbUH1JzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:55:02 -0400
Message-ID: <41305674.6030405@namesys.com>
Date: Sat, 28 Aug 2004 02:55:00 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Andrew Morton <akpm@osdl.org>,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <412D9FE6.9050307@namesys.com> <200408261812.i7QICW8r002679@localhost.localdomain> <20040827203216.GC1284@nysv.org> <Pine.LNX.4.58.0408271335421.14196@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408271335421.14196@ppc970.osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Fri, 27 Aug 2004, Markus Törnqvist wrote:
>  
>
>>People will say it when people stop using Linux on servers because
>>they can integrate metadata easier in other operating systems ;)
>>    
>>
>
>Heh. Considering that WinFS seems to be delayed yet more, I don't think 
>that's a very strong argument.
>
>Hell will freeze over before Microsoft does a filesystem right. Besides,
>WinFS is likely almost in user mode anyway, ie mostly a library, rather
>like the gnome people are already doing with nome storage.
>
>So there's really no point in trying to push your agenda by trying to 
>scare people with MS activities. Linux kernel developers do what's right 
>because it is _right_, not because somebody else does it.
>
>		Linus
>
>
>  
>
Apple will get it right.  I promise it.  I have met Dominic, and he is 
very very sharp.  Look at the Tiger demos on their website.  Simple 
interface, looks nice to me.... 

The one area he might screw up is performance, but I don't care to count 
on that.

WinFS first tried to put it all in the FS, and then it became a user 
mode library almost certainly because they are making the standard 
mistakes the database guys make when they try to emulate file systems 
without changing the core balanced tree algorithms, and their 
performance sucked and they had to back off.  It took 11 years for me to 
get it right, and they aren't as crazy-err-persistent as I am.;-)

We might get lucky and have them produce another NTFS, but then again, 
when Microsoft focuses on a task, they do much better at it than they do 
most of the time, and they are focused on WinFS.  They have hired very 
sharp people.  We can hope that they don't know how to use them, but 
when they hire people like Gerard Salton for $1 million a year, there is 
just possibly a chance that they might try to get their money's worth 
out of him.

You should not be complacent about WinFS being delayed to 2007, because 
even if I get funding for enhanced ReiserFS semantics tomorrow we also 
can't get the job done before 2007.  This is big science, not writing a 
device driver.

Finally, how much harm will it be if we do it right and it is important 
and they fail?  Suppose I am wrong about them, and we create a powerful 
unifying namespace for Linux before any other OS does?  Is that so bad?

Creating a powerful namespace at the heart of Linux is the most 
important enhancement you can make to the OS. 

Finally the storage layer is good enough to support putting the 
relationship between keywords (actually keyobjects in my scheme....) and 
their documents directly into the FS without losing performance for 
traditional file system usage patterns, and I get to stop tweaking 
performance and go have fun with semantics in the next major release.

Hans
