Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030584AbVLWRdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030584AbVLWRdE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 12:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbVLWRdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 12:33:03 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:2028 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030584AbVLWRdA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 12:33:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UOPBtImPCIQSMRsgVeXG1/fpph6zwMiq945x7Q+5Ems3pin7aNt2FNaRIRhGX7ZrapqG7G0lQ3/Q8GTEUPrvJizM3Q3fdN4E88B/VeTsLovi/4Cfzdhnzu22w7b91YBD7SR9nmBYjoC3U0twu/cuzBjcX7ZiXPK+7Vrho25lmq8=
Message-ID: <37219a840512230932m5c371f80gbde4cf652bbd1728@mail.gmail.com>
Date: Fri, 23 Dec 2005 12:32:59 -0500
From: Michael Krufky <mkrufky@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, axboe@suse.de,
       herbert@gondor.apana.org.au, michael.madore@gmail.com,
       david-b@pacbell.net, gregkh@suse.de, paulmck@us.ibm.com, gohai@gmx.net,
       luca.risolia@studio.unibo.it, p_christ@hol.gr
In-Reply-To: <43AC1791.1080806@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	 <20051222011320.GL3917@stusta.de>
	 <20051222005209.0b1b25ca.akpm@osdl.org>
	 <20051222135718.GA27525@stusta.de>
	 <20051222060827.dcd8cec1.akpm@osdl.org> <43AC1791.1080806@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/05, Bill Davidsen <davidsen@tmr.com> wrote:
> Andrew Morton wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> >
> >>not a post-2.6.14 regression
> >>
> >
> >
> > Well yeah.  But that doesn't mean thse things have lower priority that
> > post-2.6.14 regressions.
> >
> > I understand what you're doing here, but we should in general concentrate
> > upon the most severe bugs rather than upon the most recent..
>
> Hypocratic oath: "First, do no harm."
>
> If a new kernel version can't make things *better*, at least it
> shouldn't make them *worse*. New features are good, performance
> improvements are good, breaking working systems with an update is not good.
>
> I'm with Adrian on this, if you want people to test and report with -rc
> kernels, then there should be some urgency to addressing the reported
> problems.

I agree.  Quite frankly, I am extremely surprised that this matter is
even up for discussion.  Is it really so important to release 2.6.15
before the end of 2005 that we dont even have the time to fix
regressions that have already been reported in older kernels? 
ESPECIALLY given that patches are said to be available?

IMHO, I agree that new regressions are most important to fix, but I
feel that old regressions are extremely important to fix as well.  If
we know of more regressions that CAN be fixed before a kernel release,
why not do it?

Why should there be any rush to release the next mainline version?  To
make it in time for Christmas?  A better Christmas gift to the world
would be a new release without regressions, be it a month late, who
cares?  (I know -- not likely, but at least we should try)

...and that's my opinion.

-Michael Krufky
