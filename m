Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277016AbRJHRmk>; Mon, 8 Oct 2001 13:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277024AbRJHRmb>; Mon, 8 Oct 2001 13:42:31 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7665 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S277016AbRJHRmZ>; Mon, 8 Oct 2001 13:42:25 -0400
Message-ID: <3BC1E53E.2A67202A@mvista.com>
Date: Mon, 08 Oct 2001 10:41:18 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@idb.hist.no>
CC: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: low-latency patches
In-Reply-To: <20011006010519.A749@draal.physics.wisc.edu> <3BBEA8CF.D2A4BAA8@zip.com.au> <20011006150024.C2625@mikef-linux.matchmail.com> <3BC1A062.6E953751@idb.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> Mike Fedyk wrote:
> >On Fri, Oct 05, 2001 at 11:46:39PM -0700, Andrew Morton wrote:
> > > But the next rank of applications - instrumentation, control systems,
> > > media production sytems, etc require 500-1000 usec latencies, and
> > > the group of people who require this is considerably smaller.  And their
> > > requirements are quite aggressive.  And maintaining that performance
> > > with either approach is a fair bit of work and impacts (by definition)
> > > the while kernel.  That's all an argument for keeping it offstream.
> > >
> >
> > And exactly how is low latency going to hurt the majority?
> >
> > This reminds me of when 4GB on ia32 was enough, or 16 bit UIDs, or...
> 
> Low latency wobviously won't do damage by itself.  But Andrew Morton
> said it well: "And maintaining that performance
> with either approach is a fair bit of work and impacts (by definition)
> the whole kernel."
> 
> I.e. it is too much work to get right (and keep right).  The amount
> of developers is finite, their time can be better spent on other
> improvements.  All future improvement will be harder if we also have
> to _maintain_ extreme low latency.  This is not fix-it-once thing.
> 
Well, no, but do we want to improve as kernel writers, or just stay
"hackers"?  If low latency was a concern the same way lack of dead locks
and avoiding OOPs is today, don't you think we would be better coders? 
As for me, I want to shoot for the higher goal.  Even if I miss, I will
still have accomplished more than if I had shot for the mundane.

George
