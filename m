Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313604AbSDJTVi>; Wed, 10 Apr 2002 15:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313572AbSDJTVh>; Wed, 10 Apr 2002 15:21:37 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:34211 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S313599AbSDJTVf>; Wed, 10 Apr 2002 15:21:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        Robert Love <rml@tech9.net>
Subject: Re: 2.5.8-pre2: preempt: exits with preempt_count 1
Date: Wed, 10 Apr 2002 21:21:15 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16vHbV-0000M5-00@baldrick> <1018463295.6681.18.camel@phantasy> <3CB48782.9000409@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16vNee-0000K5-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 April 2002 8:42 pm, Pierre Rousselet wrote:
> Robert Love wrote:
> > On Wed, 2002-04-10 at 08:53, Duncan Sands wrote:
> >>error: halt[411] exited with preempt_count 1
> >>
> >>This was after about 24 hours of up time.  What can I do to help
> >>track down this locking problem?
>
> Duncan Sands wrote:
>  > UP x86 K6 system running 2.5.8-pre3 with preemption.
>  > Using usb-uhci.  I got the following bug when powering off:
>
> It looks like one problem, caused by some usb device driver not exiting
> cleanly.

Probably.  There was no BUG with 2.5.8-pre2 though.

Duncan.
