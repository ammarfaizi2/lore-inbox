Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWAFB6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWAFB6D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWAFB6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:58:01 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:60129 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751097AbWAFB6B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:58:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oJdGSTciswvSPNzGcSGxowO/9II5f+yKsK2iI4cpy8IlefmRM9ALJxXNZAKtW+9EUHrxIQ371IordKG/FzL97wRt7bJgyXFPFpO4wzwnFCw+55g0J0HjJNun3tuk+YKvUtGyrnE+S9/y0XtAtBaXtuNiSlUHw6qxHB7o8FqE5Hg=
Message-ID: <5bdc1c8b0601051758v71456e3n242cf35152df4561@mail.gmail.com>
Date: Thu, 5 Jan 2006 17:58:00 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.15-rc7-rt1
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       john stultz <johnstul@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1136508393.12482.3.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051228172643.GA26741@elte.hu>
	 <1136051113.6039.109.camel@localhost.localdomain>
	 <1136054936.6039.125.camel@localhost.localdomain>
	 <5bdc1c8b0601010719h40f2393cu85bae52fef35c1d2@mail.gmail.com>
	 <1136205719.6039.156.camel@localhost.localdomain>
	 <5bdc1c8b0601051133g6ed0b3b4ob699d65e4a12b699@mail.gmail.com>
	 <1136492165.847.9.camel@mindpipe>
	 <5bdc1c8b0601051258j3bfc390bsa770ddf6506d2deb@mail.gmail.com>
	 <5bdc1c8b0601051643m1d8cf0b5k8abc6697e281ffb7@mail.gmail.com>
	 <1136508393.12482.3.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Thu, 2006-01-05 at 16:43 -0800, Mark Knecht wrote:
> > On 1/5/06, Mark Knecht <markknecht@gmail.com> wrote:
> > > On 1/5/06, Lee Revell <rlrevell@joe-job.com> wrote:
> > > > On Thu, 2006-01-05 at 11:33 -0800, Mark Knecht wrote:
> > > > > I expect that I am probably still getting a low level of xruns. I
> > > > > hope one day we can make that work a bit better.
> > > >
> > > > Were you ever able to get latency tracing to work on your box?
> > > >
> > > > Lee
> > >
> > > Not yet, due to the power failure and being off line. I'll give it a
> > > shot this evening.
> > >
> > > Does anyone with an AMD64 platform have this working?
> > >
> > > Thanks,
> > > Mark
> > >
> >
> > Hi Lee,
> >    OK, I rebuilt the new kernel (2.6.15-rt2) with latency tracing
> > enabled. I still get xruns when running Jack and Aqualung. The tracing
> > doesn't show anything new although I do have the IRQ off tracing
> > turned on and don't see the long timer delays that Iused to see.
> >
> >    What the following shows is that I have a 14uS delay before
>
> Yeah 14 usec is nothing, I think we've established that this isn't a
> kernel problem.  We should take it to the JACK list.
>
> Lee

Will do.

Thanks,
Mark
