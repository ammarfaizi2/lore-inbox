Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281856AbRLDFPT>; Tue, 4 Dec 2001 00:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281815AbRLDFPI>; Tue, 4 Dec 2001 00:15:08 -0500
Received: from clouddancer.com ([64.42.30.110]:16906 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S281777AbRLDFPD>; Tue, 4 Dec 2001 00:15:03 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: thinkpad t21 lockup when using pcmcia package
In-Reply-To: <9uh82n$4ec$1@phoenix.clouddancer.com>
In-Reply-To: <1007388908.974.0.camel@zaphod> <9uh82n$4ec$1@phoenix.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20011204051423.774967843A@phoenix.clouddancer.com>
Date: Mon,  3 Dec 2001 21:14:23 -0800 (PST)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, you wrote:
>
>I seem to have narrowed down my lockups to when I use a recent 2.4
>kernel (currently on 2.4.15-pre8) and the external pcmcia source

You should probably move to 2.4.16 at a minimum.

>(currently have 3.1.29 on my system).  The main reason I use the pcmcia
>source is that I can't get my orinoco card to work with the kernel's
>modules, though it works out of the box with the pcmcia source.
>
>The problem I'm having is that if I leave my laptop on overnight (with
>the (kernel + pcmcia package combo) it locks up sometime during the
>night after a few hours of inactivity on console.  If I leave an ssh
>session into it doing stuff it still locks up.  However, if I apm
>--suspend it.  It surives the night fine.  It also seems to survive find
>if I use the built into kernel pcmcia package.

It's probably the pcmcia package, try different versions.  I can leave
my T21 up for days running any of several of the kernels from the past
2 months.

>
>As this is just a case of "hanging" and there's no messages in syslog on
>reboot, anybody have any clues on how to diagnore this, and fix this
>(and I'd personally think that understanding how to get my orinoco card
>to work with the in kernel source drivers to be a fix)

That's probably it, however I do not have that card.

>spotter@{cs.columbia.edu,yucs.org}
>http://yucs.org/~spotter/


-- 
Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."

