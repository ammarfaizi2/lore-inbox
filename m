Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbVI3QOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbVI3QOU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 12:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbVI3QOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 12:14:20 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:41232 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030336AbVI3QOU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 12:14:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BStJgCOKRupRu8uybzXqn0MzuVdznUxXK4OY+0F5xgMV8MetD7K6io6bhiKypUzL0AG36ONrKpXyE4mmlP1o3bAtmsqnRStwKMIJQQcQV1JzrWgNu6xDccw3m2q2DhUozrXzQS1z8cahb8HUxv88aZ4ZEynMsPszN/RoMNlBXnc=
Message-ID: <5bdc1c8b0509300914qb1b436eqec6df8e87d110182@mail.gmail.com>
Date: Fri, 30 Sep 2005 09:14:19 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: 2.6.14-rc2-rt7 - AMD64 runs GREAT! (threaded/non-threaded interrupts?)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1128096321.12850.16.camel@c-67-188-6-232.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0509300854o2f8ad7e9oa7736da916479458@mail.gmail.com>
	 <1128096321.12850.16.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/05, Daniel Walker <dwalker@mvista.com> wrote:
> On Fri, 2005-09-30 at 08:54 -0700, Mark Knecht wrote:
> > Hi,
> >    I finally managed to find an acceptable set of config options last
> > even that build correctly. The kernel came right up and is working
> > wonderfully on my Gentoo system. I've been up for a few hours this
> > morning with Jack going at 128/2. (<6mS latency) Music is streaming
> > with no xruns, even while doing emerge sync/emerge world operations.
> >
> >
> >    One question. In earlier rt kernels there was a way to set specific
> > ISR routinges as threaded or non-threaded through
> > /proc/irq/ISR#/DEVICE/threaded. Does anything like this exist anymore?
>
> I think there was a way to select softirqd as thread or not. This
> doesn't exist for interrupts because the ISR would need to be modified
> at compile time to work correctly. So you can't simple select drivers to
> run in interrupt context unless they are specifically written to do so.
>
> Daniel

I'll keep that in mind over the next few days. So far this is running
very, very well, although the testing is still young.

I was beginning to wonder if this machine was going to be useful. I'm
now far more confident.

Cheers and out,
Mark
