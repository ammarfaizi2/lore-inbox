Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268238AbTALFjF>; Sun, 12 Jan 2003 00:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268241AbTALFjF>; Sun, 12 Jan 2003 00:39:05 -0500
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.5]:52869 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S268238AbTALFjD>; Sun, 12 Jan 2003 00:39:03 -0500
Date: Sun, 12 Jan 2003 00:45:53 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: The GPL, the kernel, and everything else.
In-reply-to: <Pine.LNX.4.44.0301112103110.31214-100000@dlang.diginsite.com>
To: robw@optonline.net
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042350352.2375.2.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301112103110.31214-100000@dlang.diginsite.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below are two messages I wrote tonight but forgot to "reply all" so got
sent only to individuals.. In case others were interested in reading
(and probably none are, so I summarize in one e-mail), I quote both
below:

           From: 
Rob Wilkens
<robw@optonline.net>
       Reply-To: 
robw@optonline.net
             To: 
David Lang
<david.lang@digitalinsight.com>
        Subject: 
Re: The GPL, the
kernel, and
everything else.
           Date: 
12 Jan 2003
00:32:16 -0500

On Sun, 2003-01-12 at 00:10, David Lang wrote:
> the problem is that the locking that's nessasary for a storage driver
> depends on the locking that's implemented in the filesystem that's
calling
> the driver. that locking changes over time.

I suppose I should learn more about the locking requirements of the file
system before I comment further.  I'm fairly new to the linux kernel,
and haven't done kernel hacking much at all for the past 5 years.  I'm a
bit rusty, which is not to infringe on the trademark held by someone
else on the list.

> I don't know what you've been running, but windows device drivers are
not
> compatable across all the different versions of windows (try
installing a
> windows 9x driver in NT for example).

Actually, Windows 9x drivers will work on Windows NT (if you count
Windows 2000 as part of the Windows NT family).  That is the case if and
only if the driver conforms to the wdm.  

I'm too tired to read it now and summarize it, but here's an
introductory document on it:

http://www.microsoft.com/hwdev/driver/wdm/wdm.asp

-Rob




     From: 
Rob Wilkens
<robw@optonline.net>
 Reply-To: 
robw@optonline.net
       To: 
Stephen
Satchell
<list@fluent2.pyramid.net>
  Subject: 
Re: The GPL,
the kernel,
and
everything
else.
     Date: 
12 Jan 2003
00:25:49
-0500

On Sun, 2003-01-12 at 00:12, Stephen Satchell wrote:
> Microsoft doesn't use Verisign for its driver signing -- it's a
proprietary 
> system that is hard-wired into Windows.  I would guess you are
confusing 
> SSL certificates with module signatures.
> 
> As for "whois" you will find the default host for the GNU version is 
> "whois.crsnic.net", which is not Verisign.

My mistake in both of the above cases, Thanks for the correction.

> Microsoft signs modules that passes their test suite, and for which
vendors 
> pay a pretty penny (five digits' worth in US Dollars, if I recall 
> correctly).  There is no comparable central authority for Linux or GNU
> software, nor would vendors be interested in spending the kind of
dollars 
> that would be associated with that sort of certification.  If they
would, I 
> would LOVE to start such a business.

This is a perfect example of "If you build it, they will come".  I think
I read somewhere that some linux-based systems actually sell for over a
million dollars a pop (granted these are something like 64-processor
custom systems).  I don't think you'll find NT systems in that price
range.  That being the case, I'm quite sure that certain vendors would
love to say that their hardware is certified.

As an example from a parallel dimension: How is the RHCE certification
doing in popularity? 

Or for that matter LPIC (I've only taken and passed LPI 101 myself).

With both RHCE and LPI, People have taken the idea of certification and
the idea of linux and learned that you can make money.  Maybe not a lot
(who knows) but enough to justify doing it.  Red Hat probably makes more
money on training and certification than they do on sales since what
they sell is a free system.

Switching back to our original problem domain: There's no reason that
you can't offer a certification service for linux hardware drivers that
does much the same kind of testing that microsoft does on windows
hardware drivers, and then offer your seal of approval.  Sure, you'll
have to prove that your certification is meaningful and worthwhile, but
if LPI and RHCE can get some people to pay, why can't another
organizaton do it on the hardware driver front?  I'll tell you why: 
There is no standard binary hardware driver interface for any class of
device and hence no ability to run a generic test suite to validate that
it will work on all versions of a linux kernel beyond version <x>.

Of course, I could be as wrong here as I was about microsoft's signing
technology.

-Rob



