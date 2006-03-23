Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWCWPhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWCWPhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 10:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWCWPhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 10:37:39 -0500
Received: from nproxy.gmail.com ([64.233.182.184]:17339 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030212AbWCWPhi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 10:37:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PNmWFv5XEU56cO5mepQquFDKQvwCXLkP2vY9513nzuVTomIsXI1PXJ50R85aroKfJqyHlRyDLkHufiYb1M3Q6baqDhWhQLUrpo3fTimYC3Iq6FqpJMxAc16wwiIn0eP2nPYsNd48iyOorqqNxy5y0WID13vN8Kd9/qErKy5E1sI=
Message-ID: <1e1a7e1b0603230737j74fe5133qa64da4ed17990744@mail.gmail.com>
Date: Fri, 24 Mar 2006 02:37:34 +1100
From: "James Rayner" <iphitus@gmail.com>
To: "Francesco Biscani" <biscani@pd.astro.it>
Subject: Re: swap prefetching merge plans
Cc: "Con Kolivas" <kernel@kolivas.org>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <200603231458.52001.biscani@pd.astro.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060322205305.0604f49b.akpm@osdl.org>
	 <200603231804.36334.kernel@kolivas.org>
	 <200603231458.52001.biscani@pd.astro.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/06, Francesco Biscani <biscani@pd.astro.it> wrote:
> On Thursday 23 March 2006 08:04, Con Kolivas wrote:
> > For those users who feel they do have a compelling argument for it, please
> > speak now or I'll end up maintaining this in -ck only forever.  I've come
> > to depend on it with my workloads now so I'm never dropping it. There's no
> > point me explaining how it is useful yet again, though, because I just end
> > up looking like I'm handwaving. It seems a shame for it not to be available
> > to all linux users.
>
> Another "me too" from a desktop user here, for the reasons other people have
> already explained. Please consider it for merging into mainline.
>

Another 'me too' from me.

I dont use swap often, or at least I wouldnt think I would. The few
times I do hit swap, it's covered well by prefetch. It covers the
system well after returning from a heavy task, such as a game or
leaving my system to be used as a distributed build system for my
distro. Firefox, Opera, or other big applications if left open, spring
right back, usable almost instantaneously, whereas without prefetch,
there's an annoying and noticable delay.

There doesnt seem to be any compelling arguments against prefetch.
There are a lot of users swearing by it. I maintain packages in the
Arch Linux repositories with prefetch enabled, and i've had no
complaints about it, only praise about how well these kernels handle a
system under load and afterwards.

By concept alone, it's easy to see how swap prefetch can help. Here we
have an implementation in practice, and it's working very well.

James
--
iphitus - ArchCK Maintainer, Arch Developer.
Home:iphitus.loudas.com
