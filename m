Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVJKVJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVJKVJB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 17:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbVJKVJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 17:09:01 -0400
Received: from xproxy.gmail.com ([66.249.82.200]:53332 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751188AbVJKVJA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 17:09:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OiTvyDm0zXzXWVZPFdaAQFAisdbkkyuz9BBD5oiMjeu6gwH0O5c2Uy7LB6IzPBNlAAfQS+HpKY95Nn9U4R9eFSMDgE53E937XhF2PuPuG/Nz/ksaC9gSAvMb9cnjjY3SIBOnda2Nb27UuOPR5G4kIRV/KELTUTQ7FIvtgqpKyPw=
Message-ID: <5bdc1c8b0510111408n4ef45eadv1e12ec4d1271d971@mail.gmail.com>
Date: Tue, 11 Oct 2005 14:08:59 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: 2.6.14-rc4-rt1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <1129064151.5324.6.camel@cmn3.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051011111454.GA15504@elte.hu>
	 <1129064151.5324.6.camel@cmn3.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/05, Fernando Lopez-Lezcano <nando@ccrma.stanford.edu> wrote:
> On Tue, 2005-10-11 at 13:14 +0200, Ingo Molnar wrote:
> > i have released the 2.6.14-rc4-rt1 tree, which can be downloaded from
> > the usual place:
> >
> >   http://redhat.com/~mingo/realtime-preempt/
> >
> > lots of fixes all across the spectrum. x64 support and debugging
> > features on x64 should be in a much better shape now. Same for ARM.
>
> Hi Ingo, just a heads up, I'm still seeing the same problems I reported
> with rt13. After about 10 to 15 minutes of up time I see the usual
> warnings from Jack, keyboard repeat problems (repeats keys too fast) and
> random screensaver triggers. The last two seem to be "clustered" in
> time, for a little while things work, then both happen and so on and so
> forth.
>
> Sorry to not have any traces that could help, I'm still too busy to be
> able to sit down quietly and gather data.
> -- Fernando

Very strange. I've had Jack running at 64/2 since 8:52AM this morning.
Not a single xrun. I've had Ardour looping a session as well as
Aqualung playing a long playlist. No changes in the config file form
the one I sent you off line a couple of days ago.

Guess I'm lucky.
