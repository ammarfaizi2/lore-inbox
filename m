Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292195AbSBOWAb>; Fri, 15 Feb 2002 17:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292201AbSBOWAV>; Fri, 15 Feb 2002 17:00:21 -0500
Received: from zero.tech9.net ([209.61.188.187]:32783 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292195AbSBOWAK>;
	Fri, 15 Feb 2002 17:00:10 -0500
Subject: Re: Hard lockup with 2.4.18-pre9 + preempt + lock break + O1k[23] +
	rmap
From: Robert Love <rml@tech9.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Robert Jameson <rj@open-net.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020215201810.GA5310@matchmail.com>
In-Reply-To: <20020215035135.0c26b130.rj@open-net.org>
	<1013780277.950.663.camel@phantasy>  <20020215201810.GA5310@matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 15 Feb 2002 17:00:10 -0500
Message-Id: <1013810411.803.1045.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-02-15 at 15:18, Mike Fedyk wrote:

> I don't use USB, and I have had several machines lock up hard while doing
> medium to heavy IO.  I've had this happen with pre9-mjc2 and another patch
> that just contained pre9-preempt-schedo1
> (nyu.dyn.dhs.org:8080/patches/2.4.18-pre9-to-rmap12e-schedO1-rml.patch.bz2)

The -mjc and similar patches make debugging a bit, uh, hard ;)

> I'm running 2.4.18-pre9-ac3 now to see if I can reproduce without prempt and
> O(1).

If you can't reproduce it, I'd like to see if you can reproduce it
_only_ with preempt.  Also, if it happens on stock pre9 (no -ac) would
be of interest, since that doesn't have Andre's IDE patch.
 
> I have someone else from IRC that has the same issue with prempt+O(1)
> against vanilla 2.4.17.  He should be sending you a bug report soon.

Now this would be of interest, thanks.

> BTW, all machines ran the same kernel compiled for SMP, but some machines
> were UP.
>
> Has anyone else seen this?

	Robert Love

