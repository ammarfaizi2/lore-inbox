Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbVKPV0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbVKPV0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbVKPV0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:26:38 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:22416 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030484AbVKPV0i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:26:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LeIf4ciQvY5xrFe0uMSvj6BLV7oBRRIKYVKvEybPp8seczlEWG243uZafhzKTEnakc4W4bn9wtRzb2SyMQYvcPzh42nDAcIX8cdPLslkLWJ3uFehnDXbwA2GXiki0XVJKd/OEMoH2QSRHrvyO9zcXOSi1hCy4MpRO4BgvvImaZw=
Message-ID: <5bdc1c8b0511161326ob52aee8v6bc8cd9a7af3e7ec@mail.gmail.com>
Date: Wed, 16 Nov 2005 13:26:37 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.15-rc1 - NForce4 PCI-E agpgart support?
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1132172237.3008.5.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0511160650k4a9e0575h29403a5de47af952@mail.gmail.com>
	 <200511161802.47244.s0348365@sms.ed.ac.uk>
	 <5bdc1c8b0511161025q20569fa4hd8c187503e9af1c2@mail.gmail.com>
	 <200511161849.51319.s0348365@sms.ed.ac.uk>
	 <5bdc1c8b0511161154y374b131jaa6c78badc221dd0@mail.gmail.com>
	 <1132172237.3008.5.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Wed, 2005-11-16 at 11:54 -0800, Mark Knecht wrote:
> > > The alternative is ATI's proprietary driver which probably already supports
> > > your card.
> >
> > Thanks. I'll see if this old guitar player can get all of that done.
>
> Mark,
>
> You should really decide whether you're more interested in 100% xrun
> free audio performance OR better video performance and pursue one or the
> other - if you try to work on these in parallel you'll find it's one
> step forward, two steps back.  There have been many cases in the past
> where video drivers ended up doing evil things that would ruin reliable
> audio performance to get 0.1% better numbers on some Windows benchmark,
> then the same bad behavior got ported over to Linux.  I'd be especially
> cautious with the Radeon driver as much of it seems to be reverse
> engineered.  And if you read the "X spinning in the kernel" thread you
> see that apparently these GPUs can "crash" (!) in which case you seem to
> be screwed.
>
> Lee

Lee,
   I've been reading that thread with interest. Thanks.

   Also, at this point I have no reason to believe that I'm not 100%
xrun free with the right set of apps, meaning I cannot really say any
xrun I see today is kernel induced. (They may be...I just cannot say
that.) For instance, I've yet to see an xrun in days of using Ardour
and running Jack from a terminal. However running Jack from QJC and
using Aqualung results in one or two every few days. This is a low
level issue from my perspective.

   My interest is, in general, audio only. However, on the odd
afternoon I have no qualms about rebooting into a different kernel or
a different video driver that might support a bit of game playing.
That's all that's going on here. Someone recently said there might be
PCI Express support in 2.6.15 so I was just looking.

   That said, over the last couple of years I have done a couple of
jobs that are sound track related. (Pro Tools, Vegas, etc. under XP)
I'm keeping my eyes open for a tool set that might allow me a similar
opportunity one of these days under Linux. (No rush at all)

   Note: It may not be obvious, but I'm young(-ish), retired, and
pretty much get to do what I want now. The only thing that stops me
from doing this on two machines is space and noise concerns.

   Thanks for all your inputs. You've been a great help.

cheers,
Mark
