Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbVKGTX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbVKGTX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 14:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbVKGTX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 14:23:28 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:11189 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965137AbVKGTX0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 14:23:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fjPh3CUcmJfMgshjSrrnQW5ZSsrYsXWfRg+mLQc2LSKyvwNMfjuhFj0Ki2BXWIPw7xypaG+JDc4kGhXwHxz3dgPeteiIXdnv0kxlyc2NE9xxu5ktRN+mupfBP/tdXimOBdpEHCVZOu2NonD3kAzVUWXBcPzllfnvvCBi0Sek6+Q=
Message-ID: <5bdc1c8b0511071123h4a1d0da7rcae0548c2c55afb3@mail.gmail.com>
Date: Mon, 7 Nov 2005 11:23:26 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 3D video card recommendations
Cc: Steven Rostedt <rostedt@goodmis.org>, Gerhard Mack <gmack@innerfire.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hugo Mills <hugo-lkml@carfax.org.uk>, Nix <nix@esperi.org.uk>,
       Anshuman Gholap <anshu.pg@gmail.com>, Diego Calleja <diegocg@gmail.com>,
       Toon van der Pas <toon@hout.vanvergehaald.nl>, arjan@infradead.org
In-Reply-To: <1131390332.8383.83.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1131112605.14381.34.camel@localhost.localdomain>
	 <1131349343.2858.11.camel@laptopd505.fenrus.org>
	 <1131367371.14381.91.camel@localhost.localdomain>
	 <20051107152009.GA20807@shuttle.vanvergehaald.nl>
	 <20051107180045.ec86a7f2.diegocg@gmail.com>
	 <1131384624.14381.106.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0511071243350.9444@innerfire.net>
	 <1131386032.14381.110.camel@localhost.localdomain>
	 <5bdc1c8b0511071001s2d990e72s812c195d5614a894@mail.gmail.com>
	 <1131390332.8383.83.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2005-11-07 at 10:01 -0800, Mark Knecht wrote:
> >    I'm using the radeon driver from the Xorg-X11 package. The only
> > problem I've run into which remains unsolved is that when I run either
> > Quicken or IE6 under Crossover Office 5.0 all of the icons in those
> > windows programs show up in black and white, not color, so they are
> > somewhat unreadable. Other than that no real problems.
> >
>
> Um, didn't you say you were still getting audio underruns correlated
> with display activity?  I still think it's a bug in the Xorg radeon
> driver.
>
> Lee

Hi Lee,
   It very well could be a video issue causing my xruns. That's been
the biggest, but not olny,  factor, but I don't know any more. I've
gone down so many paths that haven't yielded results.

   I've tried the NoAccel and RenderAccel experiments you suggested.
You also mentioned not loading DRI which I guess isn't possible anyway
with a PCI-Express card. Anyway, I don't have it loaded.

   While I do get xruns, they are happening lately only a couple of
times a day, and usually very late in the day after the machine has
been running for 12+ hours. If I pull Jack back to 256/2 then I don't
think I get them at all so I'm living with it for now and hoping for a
solution one of these days. Low latency really only matters to me when
recording which is <5% of the time.

   I'm most interested in a kernel developer finding the time to fix
the IRQoff latency testing on 64-bit machines so I can look at that.

   In case the question comes to mind for others, this HDSP 9652 sound
card runs for months at a time at 64/2 in my older Via 32-bit machine.
The problem only surfaced when I moved it to my new AMD64 machine.

   Anyway, that's status. It's a frustration, not a killer issue.

Cheers,
Mark
