Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267490AbTALUL7>; Sun, 12 Jan 2003 15:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267491AbTALUL7>; Sun, 12 Jan 2003 15:11:59 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:53617 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S267490AbTALULw>; Sun, 12 Jan 2003 15:11:52 -0500
Message-ID: <3E21CE0F.4020401@blue-labs.org>
Date: Sun, 12 Jan 2003 15:20:31 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030110
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: robw@optonline.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ben Ford <ben@kalifornia.com>
Subject: Re: any chance of 2.6.0-test*?
References: <Pine.LNX.4.44.0301121134340.14031-100000@home.transmeta.com> <1042401596.1209.51.camel@RobsPC.RobertWilkens.com>
In-Reply-To: <1042401596.1209.51.camel@RobsPC.RobertWilkens.com>
X-Enigmail-Version: 0.71.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Gotos aren't the root of code evil.  Poor design style is and poor 
preparation is the root of spaghetti code.  Use the right tool for the 
job which includes 'goto'.  Every teacher that I've met who has an 
objection to the use of gotos has been quite naive, often recommends 
avoiding pointers, frequently suggests you restrict your strings to 255 
characters or less, etc, etc.  The oddball extras vary from teacher to 
teacher, but the overall impression of the teacher makes me want to 
avoid them even with that 10 foot pole.

It's not the fault of the student for being taught wrong, but it is the 
fault of the student for ignoring possibile variances of others.  
Particularly the "worldly wise"; people who actually write code for the 
real world v.s. lectures.

David

Rob Wilkens wrote:

>On Sun, 2003-01-12 at 14:38, Linus Torvalds wrote:
>  
>
>>I think goto's are fine
>>    
>>
>
>You're a relatively succesful guy, so I guess I shouldn't argue with
>your style.
>
>However, I have always been taught, and have always believed that
>"goto"s are inherently evil.  They are the creators of spaghetti code
>(you start reading through the code to understand it (months or years
>after its written), and suddenly you jump to somewhere totally
>unrelated, and then jump somewhere else backwards, and it all gets ugly
>quickly).  This makes later debugging of code total hell.  
>
>Would it be so terrible for you to change the code you had there to
>_not_ use a goto and instead use something similar to what I suggested? 
>Never mind the philosophical arguments, I'm just talking good coding
>style for a relatively small piece of code.
>
>If you want, but comments in your code to meaningfully describe what's
>happening instead of goto labels.
>
>In general, if you can structure your code properly, you should never
>need a goto, and if you don't need a goto you shouldn't use it.  It's
>just "common sense" as I've always been taught.  Unless you're
>intentionally trying to write code that's harder for others to read.
>
>-Rob
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+Ic4P74cGT/9uvgsRAt1QAKCb7ryMMG5iBwTefYgDB7HLuDkRngCeNSq/
M/euGkdIdXpv6IZ1Rw9ikEo=
=Yy9i
-----END PGP SIGNATURE-----

