Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311500AbSCNEPT>; Wed, 13 Mar 2002 23:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311501AbSCNEPJ>; Wed, 13 Mar 2002 23:15:09 -0500
Received: from relay1.pair.com ([209.68.1.20]:6665 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S311500AbSCNEO7>;
	Wed, 13 Mar 2002 23:14:59 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C902631.3A406D51@kegel.com>
Date: Wed, 13 Mar 2002 20:25:21 -0800
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Dan Kegel wrote:
> > I'm all in favor of a userspace fix.  I suggested a patch
> > to glibc to fix this.  Ulrich rejected it; I'm trying
> > to coax out of him how he thinks profiling of multithreaded
> > programs on Linux should be fixed.
> 
> Good and I'll reject any kernel patches 8)
> 
> If Ulrich won't talk then talk to the NGPT people. Maybe a little
> competition will warm things up.

Surely Ulrich will come up with a constructive proposal for
how to make gprof work with LinuxThreads.  He wouldn't
want an important tool like gprof to remain broken for
years, would he?

While I await his constructive response, perhaps I'll get my 
glibc patch in shape.
I am maintainer of what amounts to a tiny embedded linux
distribution, and I'm pretty sure my users would like
gprof to work.  (In fact, my boss's boss would really
like gprof to work.  This problem has a lot of visibility.)

- Dan
