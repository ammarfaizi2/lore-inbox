Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267544AbUHTBJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267544AbUHTBJE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 21:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267548AbUHTBJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 21:09:04 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:17567 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S267544AbUHTBI4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 21:08:56 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: GNU make alleged of "bug" (was: PATCH: cdrecord: avoiding scsi device numbering for ide devices)
Date: Thu, 19 Aug 2004 21:08:52 -0400
User-Agent: KMail/1.6.82
Cc: Matthias Andree <matthias.andree@gmx.de>
References: <200408191600.i7JG0Sq25765@tag.witbe.net> <200408191341.07380.gene.heskett@verizon.net> <20040819194724.GA10515@merlin.emma.line.org>
In-Reply-To: <20040819194724.GA10515@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200408192108.52876.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.62.54] at Thu, 19 Aug 2004 20:08:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 August 2004 15:47, Matthias Andree wrote:
>On Thu, 19 Aug 2004, Gene Heskett wrote:
>> Humm, I got many many losses of header stuff messages from:
>> [root@coyote cdrecord]# make --version
>> GNU Make 3.80
>
>The "bug" is not specific to GNU make 3.80 but can also be seen in
>3.78.1 for instance.
>
>The "bug" however is purely cosmetical.
>
>GNU make writes a message that an "include" file is missing, but it
>finds it has a rule, generates the include file, pulls it in and
>continues as though the file had always been there.
>
>For instance if you have this Makefile:
>
># BEGIN Makefile
>all:    hello
>hello.d:
>        makedepend -f- hello.c >$@
>include hello.d
># END Makefile
>
>You'll get at "make" time:
>
>Makefile:5: hello.d: No such file or directory
>makedepend -f- hello.c >hello.d
>cc   hello.o   -o hello
>
>and a working hello program.
>
>Jörg's complaints about GNU make aren't false but aren't helpful
> either and certainly don't warrant waiting 15 seconds after that
> message.
>
Agreed.  Maybe he thinks those of us who speak english still need that 
long to deciher what he thinks is english but in reality reminds me 
of engrish.com, just a different language for a starting point.  I 
can get the meaning in 3 seconds, but to fully read it, and translate 
it into real english takes all of that 15 seconds.  Sigh.

>There is no bug, just this confusing "Makefile:5: hello.d: No such
> file or directory".
>
>> So apparently 3.80 is a regression in this case.
>
>No, it isn't.

In light of that explanation, I can see why both Jorg is mewling about 
it, and that it really isn't worth his stepping on our tails over it.

Thanks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
