Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286853AbRL2Hlb>; Sat, 29 Dec 2001 02:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287150AbRL2HlW>; Sat, 29 Dec 2001 02:41:22 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:37894 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S286853AbRL2HlF>; Sat, 29 Dec 2001 02:41:05 -0500
Subject: Re: State of the new config & build system
From: Miles Lane <miles@megapathdsl.net>
To: nknight@pocketinet.com
Cc: Keith Owens <kaos@ocs.com.au>, Mike Castle <dalgoda@ix.netcom.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <WHITELXfKCzxg8cL3zb00000801@white.pocketinet.com>
In-Reply-To: <9467.1009601050@ocs3.intra.ocs.com.au> 
	<WHITELXfKCzxg8cL3zb00000801@white.pocketinet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2001.12.21.18.01 (Preview Release)
Date: 28 Dec 2001 23:42:17 -0800
Message-Id: <1009611737.1434.14.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-12-28 at 22:59, Nicholas Knight wrote:

<snip>

> > What Mr. Fishtank seems to overlook is that kbuild 2.5 is far more
> > flexible and accurate than 2.4, including features that lots of
> > people want, like separate source and object trees.  Now that the
> > overall kbuild design is correct, the core code can be rewritten for
> > speed. And that will be done a couple of weeks after kbuild 2.5 goes
> > into the kernel, then I expect kbuild 2.5 to be faster than kbuild
> > 2.4 even on full builds.
> >
> 
> What, exactly, is the point of merging something that nobody is going 
> to use unless they want to test it, in which case they can grab a patch 
> from somewhere?

You don't seem to be reading Keith's message.

The point of merging is that Keith needs time to fix the 
performance problem.  Plus, additional testing would probably 
be helpful.

> It's half the speed of the current system. The current system works, no 
> matter how horrible its internals can be. That makes the NEW system 
> BROKEN. 

No, it's known to be slow in some circumstances.

> If it's KNOWN to be BROKEN prior to merge then it shouldn't 
> even be in a 2.5.*-pre#.

Uh, many drivers cannot be built in the current 2.5 tree.  
Temporary brokenness is acceptable in the development tree.  
It is meant to be _unstable_.  I recall periods when the 
2.3 kernel was corrupting data for many users.  This period
lasted about a week, IIRC.  The kbuild 2.5 system will slow 
people down, but not hose their development system installations.
I personally think two weeks of working at a slower pace is 
an acceptable trade-off for the longterm benefits that Keith
has mentioned.  It seems odd that several people in this
discussion seem to have ignored the repeated statements that
Keith will have little time for dealing with the performance
rewrite until the multiple kernel tree synchronization 
time sink goes away.  Telling Keith that he needs to go on
spinning his wheels while he cannot find time to deal with
the problem you are asking him to fix seems sort of unhelpful.
Perhaps you'd be willing to assist him in the rewrite?

	Miles

