Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbVJUSwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbVJUSwh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbVJUSwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:52:37 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:16840 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965084AbVJUSwh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:52:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YbM2MRQegl+n3bavgnaqrKXz6SGfWuweGafjV/vq+X450sElgVAwsBgq9CvFLyvMhGACBJafcn8YTnbfb+gfBY8/ZJkGVGtuFN0JWJYpfZh0i0Z+w+fosPpEYYqX+MIxX/WkRfv76M1iy5+M4DYVewMjMZ/jzx3exmkvIJLf6ZA=
Message-ID: <5bdc1c8b0510211152m592d95cfte57dc7e9b027f87a@mail.gmail.com>
Date: Fri, 21 Oct 2005 11:52:36 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.14-rc5-rt3 - `IRQ 8'[798] is being piggy
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1129920323.17709.2.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510211003j4e9bf03bhf1ea8e94ffe60153@mail.gmail.com>
	 <5bdc1c8b0510211040s40f3f9bbj7f83e174d7b6d937@mail.gmail.com>
	 <1129920323.17709.2.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-10-21 at 10:40 -0700, Mark Knecht wrote:
> > On 10/21/05, Mark Knecht <markknecht@gmail.com> wrote:
> > > Hi,
> > >    Maybe I'm catching something here? Maybe not - no xruns as of yet,
> > > but I've never seen these messages before. Kernel config attached.
> > >
> > >    dmesg has filled up with these messages:
> > >
>
> This isn't a real problem.  You enabled CONFIG_RTC_HISTOGRAM.  Don't do
> that.
>
> Lee


Right, but the 'piggy' messages are a real prblem, aren't they?

Thanks,
Mark
