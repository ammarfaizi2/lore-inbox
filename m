Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276138AbRJHMtH>; Mon, 8 Oct 2001 08:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276824AbRJHMs6>; Mon, 8 Oct 2001 08:48:58 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:39954 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S276138AbRJHMsv>; Mon, 8 Oct 2001 08:48:51 -0400
Message-ID: <3BC1A062.6E953751@idb.hist.no>
Date: Mon, 08 Oct 2001 14:47:30 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.11-pre2 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: low-latency patches
In-Reply-To: <20011006010519.A749@draal.physics.wisc.edu> <3BBEA8CF.D2A4BAA8@zip.com.au> <20011006150024.C2625@mikef-linux.matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
>On Fri, Oct 05, 2001 at 11:46:39PM -0700, Andrew Morton wrote:
> > But the next rank of applications - instrumentation, control systems,
> > media production sytems, etc require 500-1000 usec latencies, and
> > the group of people who require this is considerably smaller.  And their
> > requirements are quite aggressive.  And maintaining that performance
> > with either approach is a fair bit of work and impacts (by definition)
> > the while kernel.  That's all an argument for keeping it offstream.
> >
> 
> And exactly how is low latency going to hurt the majority?
> 
> This reminds me of when 4GB on ia32 was enough, or 16 bit UIDs, or...

Low latency wobviously won't do damage by itself.  But Andrew Morton
said it well: "And maintaining that performance
with either approach is a fair bit of work and impacts (by definition)
the whole kernel."

I.e. it is too much work to get right (and keep right).  The amount
of developers is finite, their time can be better spent on other
improvements.  All future improvement will be harder if we also have
to _maintain_ extreme low latency.  This is not fix-it-once thing.

Helge Hafting
