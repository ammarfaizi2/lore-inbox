Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbTDTXdw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 19:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbTDTXdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 19:33:52 -0400
Received: from fluent2.pyramid.net ([206.100.220.213]:57504 "EHLO
	fluent2.pyramid.net") by vger.kernel.org with ESMTP id S263731AbTDTXdv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 19:33:51 -0400
X-Not-Legal-Opinion: IANAL I am not a lawyer
X-For-Entertainment-Purposes-Only: True
Message-Id: <5.2.0.9.0.20030420163516.02076ec0@fluent2.pyramid.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sun, 20 Apr 2003 16:45:49 -0700
To: "Leonard Milcin, Jr" <thervoy@post.pl>
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Re: (OT) md5sum proving to be an EXCELLENT memory test
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3EA317F6.2000504@post.pl>
References: <5.2.0.9.0.20030420132915.01d28c40@fluent2.pyramid.net>
 <6uwuhpl2u5.fsf@zork.zork.net>
 <Pine.LNX.4.44.0304192002580.9909-100000@penguin.transmeta.com>
 <6uwuhpl2u5.fsf@zork.zork.net>
 <5.2.0.9.0.20030420132915.01d28c40@fluent2.pyramid.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:58 PM 4/20/03 +0200, Leonard Milcin, Jr wrote:
> > (...)
>>as perfect.)  Perform md5sum on the files on the server and save the 
>>results, and the signatures would be different from run to run on the 
>>same files.
>>Incompatible RAM.
> > (...)
>
>I had the same situation with some cheap mobo (ECS K7S5A+) of friend of 
>mine. You don't need to check md5sums. Why is MD5 better than any other 
>method? I just simply found, that when I copy file A to B, and then A to 
>C, it is possible that B and C differs. Most of the time with one byte.
>
>The advice is to use some good memory test suite from time to time - it 
>will do better its job than you just checking signatures on large files.

The "good memory test suite" I have didn't catch it.  The copy method you 
suggest didn't catch it.  The BIOS memory check didn't catch it.  Only the 
linux compile method -- mentioned on this list -- did catch it.  And so did 
using md5sum on very long files.

(Maybe you missed reading the part that md5sum on small files never 
fails.  File copies on smaller files don't fail, either.  Otherwise, how 
did I get a Linux environment loaded and running with no problem?)

I'm pissed about this because, when I purchased the RAM a year and a half 
ago, I used the memory test suite to see if the stuff would work in these 
servers, AND THE TESTS PASSED.  So I accepted the RAM.  The money-back 
guarantee is long gone.  No, I didn't try a kernel compile.  My stupidity 
for believing in running only one diagnostic.

The server in question ran for a year as a moderate-use Web server, and 
would mystery only once in a great while.  It was taken out of service when 
a faster computer replaced it.  It's only now I find out the truth about 
the RAM incompatibility in it, when I tried to use the 40-GB hard drive in 
it as a staging vehicle.


--
X -> unknown; Spurt -> drip of water under pressure
Expert -> X-Spurt -> Unknown drip under pressure.

