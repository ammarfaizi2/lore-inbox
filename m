Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274640AbRITUg1>; Thu, 20 Sep 2001 16:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274635AbRITUgT>; Thu, 20 Sep 2001 16:36:19 -0400
Received: from maile.telia.com ([194.22.190.16]:2528 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S274640AbRITUgN>;
	Thu, 20 Sep 2001 16:36:13 -0400
Message-Id: <200109202036.f8KKaUv18307@maile.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: george anzinger <george@mvista.com>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Subject: Re: [PATCH] latency-profiling
Date: Thu, 20 Sep 2001 22:31:40 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
In-Reply-To: <200109200609.f8K69uQ26778@mailc.telia.com> <3BAA49B5.E02FA5E7@mvista.com>
In-Reply-To: <3BAA49B5.E02FA5E7@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursdayen den 20 September 2001 21.55, george anzinger wrote:
> Roger Larsson wrote:
> > Hi,
> >
> > I ported my old latency-profiling patch to 2.4.10-pre10 with
> > the reschedulable kernel patch. (I have not checked that it is
> > preemption safe itself...)
> >
> > This patch works a little different from Robert Loves.
> > Since it samples the execution location at ticks.
> > It is possible to instrument an ordinary kernel too...
>
> It gives experienced latencies rather than potential latencies, but more
> important from the developer/maintainers point of view, "Robert Loves"
> patch provides information on the bad guys, i.e. the reason for the long
> latency, which, hopefully, will allow them to be addressed by competent
> maintainers.
>

Yes, but my technique can be applied to any kernel. It does not require
an preemptible kernel...

I.e. measures time from the moment a reschedulation was reqired to it
is actually done - independent of how it is done...

And if you run something that needs periodic reshedules you will detect
actual problems.

And thus it can be used as a bench, it is hard to describe skips in music,
textual data is easier to send by mail...

But I agree that Roberts is better to find the critical ones!

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
