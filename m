Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbVKBEFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbVKBEFM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 23:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbVKBEFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 23:05:12 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:41107 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751487AbVKBEFK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 23:05:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tqUTULy4B9wofrP/sDq7rdd82eoD7Vq3XcH6Nvq19kH8/4N8UktpAmq3JrXjYj329xQDhpwDKm89UzWDSaYMsg01sHkh02JeN8u+TTsQ1NxfD8ctPAKCVuQM8TiU+ddco5CmI7G69DeindqhU+B95cJIHXnKR+/I9zgoe3jZPpk=
Message-ID: <cb2ad8b50511012005g3bc39f36odd0ae1038e2b9b52@mail.gmail.com>
Date: Tue, 1 Nov 2005 23:05:09 -0500
From: Carlos Antunes <cmantunes@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.14-rt1
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1130902342.29788.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <20051030133316.GA11225@elte.hu>
	 <1130876293.6178.6.camel@cmn3.stanford.edu>
	 <1130899662.12101.2.camel@cmn3.stanford.edu>
	 <cb2ad8b50511011855w41bf4a30l3127cc36dcacb094@mail.gmail.com>
	 <1130900716.29788.22.camel@localhost.localdomain>
	 <cb2ad8b50511011926w11116fdasd22227ca249f18fc@mail.gmail.com>
	 <1130902342.29788.23.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 2005-11-01 at 22:26 -0500, Carlos Antunes wrote:
>
> >
> > It's a simple program I put together to test wakeup latency. Each
> > thread basically sleeps for 20ms, wakes up and executes a couple of
> > instructions and goes back to sleep for another 20ms. Multiply this by
> > a thousand. What I found out is that, inthis situation, and using
> > realtime-preempt, SCHED_OTHER offers 3 orders of magnitude less
> > latency than SCHED_FIFO or SCHED_RR. Which suggests to me there is
> > something fishy going on.
>
> Could you supply this program?  I like to see what it does on my
> systems.
>

Steve,

Here's the thing:
http://www.nowthor.com/OpenPBX/timing.c

Let me know what kind of results you get.

Thanks!

Carlos


--
"We hold [...] that all men are created equal; that they are
endowed [...] with certain inalienable rights; that among
these are life, liberty, and the pursuit of happiness"
        -- Thomas Jefferson
