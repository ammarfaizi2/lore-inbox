Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSIHQ0x>; Sun, 8 Sep 2002 12:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316971AbSIHQ0x>; Sun, 8 Sep 2002 12:26:53 -0400
Received: from packet.digeo.com ([12.110.80.53]:20644 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S316677AbSIHQ0w>;
	Sun, 8 Sep 2002 12:26:52 -0400
Message-ID: <3D7B7EC6.EFD38352@digeo.com>
Date: Sun, 08 Sep 2002 09:45:58 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Axel Siebenwirth <axel@hh59.org>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.33-mm5
References: <3D7AF270.BE4AFBEB@digeo.com> <20020908151159.GA5260@prester.freenet.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Sep 2002 16:31:28.0805 (UTC) FILETIME=[2EC14550:01C25755]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Siebenwirth wrote:
> 
> Hi Andrew!
> 
> On Sat, 07 Sep 2002, Andrew Morton wrote:
> 
> > I'd appreciate it if people could grab this one, be nasty to it
> > and send a report.
> 
> What are your favorite tests to run? I'd like to send you some useful test
> results. But which do you like to see?

I've already run my favourite tests ;)  The value of external testing is
in the extra coverage which it gives - different hardware, different
tests.  And also different requirements: there may be things which I
think are cool, but which you think suck.

So... The real test is of course "daily use".  If it works OK in daily
use for you, and for everyone else then we ship 2.6.  By definition.

Of course, on top of daily use it is best to run additional stress
tests to find problems more quickly.  Large desktop applications, web
and file servers, databases, etc would be interesting.  CD burning,
funny old PIO-mode IDE drives, stress testing with gigabt NICs,
you name it.  Coverage.
