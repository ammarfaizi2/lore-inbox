Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316717AbSEQWlQ>; Fri, 17 May 2002 18:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316718AbSEQWlP>; Fri, 17 May 2002 18:41:15 -0400
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:45316
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S316717AbSEQWlO>; Fri, 17 May 2002 18:41:14 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: akpm@zip.com.au
X-Envelope-Sender: stevie@qrpff.net
Message-Id: <5.1.0.14.2.20020517183411.02198598@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 17 May 2002 18:35:06 -0400
To: Andrew Morton <akpm@zip.com.au>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
From: Stevie O <stevie@qrpff.net>
Subject: Re: [PATCH] Fix BUG macro
Cc: Rusty Russell <rusty@rustcorp.com.au>, Ghozlane Toumi <ghoz@sympatico.ca>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <3CE54EE0.70FB57E9@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:41 AM 5/17/2002 -0700, Andrew Morton wrote:

>> Well, a way to work around this would be to replace
>> 
>>         -I$(TOPDIR)/include
>> 
>> with
>> 
>>         -I../../include
>> 
>> on the command line, I suppose, with the right amount of "../". A bit
>> hackish, but it should do.
>
>Almost..  The final solution to all problems is to merge
>kbuild-2.5 and then to teach it to use relative pathnames
>when performing a build within the source tree.  Presumably
>that's not hard, but I'm surely about to learn why it's
>not feasible.

What if you just let $TOPDIR = '../..' ?


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

