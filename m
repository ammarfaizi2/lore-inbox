Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbVJDWYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbVJDWYq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 18:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVJDWYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 18:24:45 -0400
Received: from web35511.mail.mud.yahoo.com ([66.163.179.135]:25257 "HELO
	web35511.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965016AbVJDWYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 18:24:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=piKjeFFiMBAhU6KAc35yvm4IPcCEk3kzr9TOMJ+QPslDlxS49XeaOqUvAHFly7D6Y14WbKTMh4XfSqXk6ptM6OP5y2EFY9jP9O3gWjQWQrQidNVaGkOITLiV26V9g0ZzpBwgqnaMlX/btUjR8SEYtfepgP8S/nog1m3/X/FCBms=  ;
Message-ID: <20051004222445.7563.qmail@web35511.mail.mud.yahoo.com>
Date: Tue, 4 Oct 2005 15:24:44 -0700 (PDT)
From: Dan C Marinescu <dan_c_marinescu@yahoo.com>
Subject: Re: The price of SELinux (CPU)
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4342E7B6.7050500@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any results not based on actual measurement are
> called "guesses" rather 
> than "data." Such deep knowlege is useful to
> determine what to measure, 
> not what you would measure if you thought it were
> necessary.

in my world, we design stuff, calculate bigO, then
implement and finally measure. we don't write code at
inspiration and then measure and if kinda s*x we apply
patches then measure again, etc etc etc, that's _all_
i meant... (keep measuring something not really
designed for this O or that O may be a huge waste of
time). even in qa, the best engineers find
short-cuts... even in black box testing, but then you
get gray box, and white box testing and finally us
(r&d).

> The measurements are very useful, in that they show
> the magnitude of the 
> performance impact using a benchmark which was
> constructed to emulate 
> certain real world loads. Since no one number or
> even series of numbers 
> can fully describe what *will* happen, but these
> numbers show what 
> *could* happen.

correct, but you should measure something which you
first designed then implemented... not the other way
around...

> > very same elementary I/O, linus would have
> accepted
> > this degradation... my $0.02... :-)
> 
> For some applications the issue isn't how fast the
> O/S runs, but if it 
> is secure enough to be run at all. Given the speed

hey, absolutely... i was about to add that too (last
night) but it was kinda late... but how would you
define "secure"... it's kinda like huge, eh? in my
$0.02, secure means secure enough for the purpose
(whatever that may be...) and it's way over the scope
of this email... when this is equivalated with "oh,
it's kinda slow, but it's worth cause it's safer"...
well, i kinda have doubts on that... (check for a
second oppinion in your sec strategy, etc...)

> of even commodity 
> computers, it's probable that even a 2:1 slowdown
> would still result in 
> useful operation, compared to doing the work without
> a computer.

well, yes and now... it's a long story...

> I can't speak for Linus' thinking of course, but I
> have worked in secure 
> environments before, both DOD and DOE, and
> information control is vital.

yeah... remember the old days (running around with
floppies because networking was "unsafe" blah blah
blah...)

nice talking 2u bill,
   d

> 
> -- 
>     -bill davidsen (davidsen@tmr.com)
> "The secret to procrastination is to put things off
> until the
>   last possible moment - but no longer"  -me
> 



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
