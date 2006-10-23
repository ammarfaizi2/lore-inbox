Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWJWUJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWJWUJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWJWUJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:09:10 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:5401 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965025AbWJWUJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:09:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iPEGNwgyVkQMbhWuCs1rPE9n7K2SjPuOPoeaugLTBg2/Q1BCffPdpNo1B24QctvIebpFhGAQv2u61GijJJni6UUkmBJLJc+Lcyj4SqPhi2v36TRH4jY5162Ga+sWvGxftWgNCRfpU1Ib+Ikm69qmj9KbZIuCCtiVsOKI0GchCqE=
Message-ID: <5bdc1c8b0610231309q246a8964g404c9edb5182a3c4@mail.gmail.com>
Date: Mon, 23 Oct 2006 13:09:08 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: tglx@linutronix.de
Subject: Re: -rt7 announcement? (was Re: 2.6.18-rt6)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1161629955.22373.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061018083921.GA10993@elte.hu>
	 <1161356444.15860.327.camel@mindpipe>
	 <1161621286.2835.3.camel@mindpipe>
	 <1161628539.22373.36.camel@localhost.localdomain>
	 <5bdc1c8b0610231144s420c1523p43af2a8349bac04@mail.gmail.com>
	 <1161629955.22373.40.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 2006-10-23 at 11:44 -0700, Mark Knecht wrote:
<SNIP>
>
> >    In 2.6.18-rt6 I turned on HRT support, left 1000 nanoseconds for
> > the timing, but did not enable dynamic ticks since I wasn't sure it
> > was OK on AMD64. Should I be using DynTicks with an AMD64 single
> > processor? With a dual-processor?
>
> Should work
>
<SNIP>

I turned on DynTicks. When I rebooted with the new kernel I got a lot
of fsck messages about file systems times being in the future and
being fixed. Is this a 1-time deal?

Other than that no problems. dmesg appears to be clean so far.

- Mark
