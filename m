Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287769AbSAFPse>; Sun, 6 Jan 2002 10:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287854AbSAFPsZ>; Sun, 6 Jan 2002 10:48:25 -0500
Received: from ns.ithnet.com ([217.64.64.10]:23822 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287769AbSAFPsS>;
	Sun, 6 Jan 2002 10:48:18 -0500
Date: Sun, 6 Jan 2002 16:48:13 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Ken Brownfield <brownfld@irridia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-Id: <20020106164813.23555724.skraw@ithnet.com>
In-Reply-To: <20020105154053.A18545@asooo.flowerfire.com>
In-Reply-To: <20020103142301.C4759@asooo.flowerfire.com>
	<200201040019.BAA30736@webserver.ithnet.com>
	<20020103232601.B12884@asooo.flowerfire.com>
	<20020104140321.51cb8bf0.skraw@ithnet.com>
	<20020104175050.A3623@asooo.flowerfire.com>
	<20020105154053.A18545@asooo.flowerfire.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002 15:40:53 -0600
Ken Brownfield <brownfld@irridia.com> wrote:

> One problem is that I've never heard of it and don't know where to get
> it. ;)

[Sent in off-LKML mail]


> | What exactly do you mean with "high IRQ rate"? Can you show so numbers from
> | /proc/interrupts and uptime for clarification?
> 
> I did, back in the archives.  I don't have easy access to archives etc,
> right now, but I might repost since it's been a while.

I read all your LKML mails since beginning of November, could find a lot about
cpu, configs,tops etc but not a single "cat /proc/interrupts" together with
uptime.

> Well, reboots are the problem over possible oopses (or data corruption,
> even more fun.)  But on your recommendation I'll give Martin's mod a
> try, given a URL.  Does Martin's patch play well with -aa?  How about
> Martin+10_vm in -pre2? ;-)

According to the ongoings of your mails you seem to try really a lot of things
to make it work out. I recommend not to intermix the patches a lot. I would
stay close to marcelo's tree and try _single_ small patches on top of that. If
you mix them up (even only two of them) you won't be able to track down very
well, what is really better or worse.

One thing I would like to ask here is this (as you are dealing with oracle
stuff): why does oracle recommend to compile the kernel in 486 mode? I talked
to someone who uses oracle on 2.4.x and he told me it is even in the latest
docs. What is the voodoo behind that? Btw he has no freezes or the like, but
occasional coredumps from oracle processes, which he states as "not nice, but
no showstopper" as his clients reconnect/retransmit with only a slight delay.
This may be related to VM, thats why I will try to convince him of some patches
:-) and have a look at the coredump-frequency.

Regards,
Stephan

