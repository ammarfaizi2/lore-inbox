Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280954AbRKTIEy>; Tue, 20 Nov 2001 03:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280957AbRKTIEn>; Tue, 20 Nov 2001 03:04:43 -0500
Received: from smtprt15.wanadoo.fr ([193.252.19.210]:34209 "EHLO
	smtprt15.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S280954AbRKTIEh>; Tue, 20 Nov 2001 03:04:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Robert Love <rml@tech9.net>
Subject: Re: [bug report] System hang up with Speedtouch USB hotplug
Date: Tue, 20 Nov 2001 09:03:59 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Kilobug <kilobug@freesurf.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <E165lQB-0001DZ-00@baldrick> <1006204883.826.0.camel@phantasy>
In-Reply-To: <1006204883.826.0.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E1665su-0000rl-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 10:21 pm, Robert Love wrote:
> On Mon, 2001-11-19 at 05:12, Duncan Sands wrote:
> > Johan Verrept's driver has two parts: a kernel module and
> > a user space management utility.  The kernel module is open
> > source (GPL).  It has problems with SMP and preempt, but
> > otherwise works well.
>
> Anything that has problems with SMP is going to have problems with
> preempt.  Further, most any module will need to be compiled as a
> preemptible kernel version, just like you need SMP versions.

Yes, it has problems with preempt because it has problems
with SMP.  But it seemed clearer to say "with SMP and preempt".

> Binary modules just are always going to be a problem unless we
> standardize more, and I'm not saying that is a good idea ...

Lucky this isn't a binary module we're talking about then!

Duncan.
