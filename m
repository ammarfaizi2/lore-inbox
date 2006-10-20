Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWJTPxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWJTPxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWJTPxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:53:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:55110 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932263AbWJTPxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:53:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J2MkJPwp3tBkAbOTgMvuITEZiZ6jcGj7ZzkxOXyFJcsfrwYQhbBDhBplPsn8bOZLO66/S7QgIaPV0cs/e6jOv0Qf/txdPCdDo98UWVIhFWl443KIbLyKsFKHJ1uxlJPBpJskhTPKqZ0wVzrbnTtTigupL4S4BK/hywye94VzEgI=
Message-ID: <5bdc1c8b0610200853y2767784jf8ca154a6cfeed5d@mail.gmail.com>
Date: Fri, 20 Oct 2006 08:53:10 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: 2.6.18-rt6
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Dipankar Sarma" <dipankar@in.ibm.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Mike Galbraith" <efault@gmx.de>, "Daniel Walker" <dwalker@mvista.com>,
       "Manish Lachwani" <mlachwani@mvista.com>, bastien.dugue@bull.net
In-Reply-To: <1161356444.15860.327.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061018083921.GA10993@elte.hu>
	 <1161356444.15860.327.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Wed, 2006-10-18 at 10:39 +0200, Ingo Molnar wrote:
> > i've released the 2.6.18-rt6 tree, which can be downloaded from the
> > usual place:
> >
> >   http://redhat.com/~mingo/realtime-preempt/
>
> This does not work here.  It boots but then wants to fsck my disks, and
> dies with a sig 11 in fsck.ext3.  This is 100% reproducible and booting
> 2.6.18-rt5 works and does not want to fsck the disks.
>
> Sorry I don't have more information, the box is headless and in
> production so I have limited debugging bandwidth.
>
> Do you need my .config?
>
> Lee
>

I've been running 2.6.18-rt6 for a couple of days now. No problems so far.

mark@lightning ~ $ uname -a
Linux lightning 2.6.18-rt6 #2 PREEMPT Wed Oct 18 10:18:51 PDT 2006
x86_64 AMD Athlon(tm) 64 Processor 3000+ GNU/Linux
mark@lightning ~ $ uptime
 08:52:52 up 21:32,  2 users,  load average: 0.93, 0.73, 0.47
mark@lightning ~ $


I am single processor. HRT is turned on. I am not using the DynTicks
thing as I don't know what it's supposed to do.

Anyway, 2.6.18-rt5 wouldn't boot reliably for me so it seems we are
out of phase with each other. Maybe compare .config's?

- Mark
