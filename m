Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262845AbVBBXDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbVBBXDs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 18:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVBBXB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:01:28 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:55518 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262789AbVBBXAt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:00:49 -0500
Message-Id: <200502022259.j12Mxtau001972@localhost.localdomain>
To: Bill Huey (hui) <bhuey@lnxw.com>
cc: Ingo Molnar <mingo@elte.hu>, "Jack O'Quin" <joq@io.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature 
In-reply-to: Your message of "Wed, 02 Feb 2005 13:34:02 PST."
             <20050202213402.GB14023@nietzsche.lynx.com> 
Date: Wed, 02 Feb 2005 17:59:54 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.197.207.111] at Wed, 2 Feb 2005 17:00:40 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It's clever that they do that, but additional control is needed in the
>future. jackd isn't the most sophisticate media app on this planet (not
>too much of an insult :)) and the demands from this group is bound to

Actually, JACK probably is the most sophisticated media *framework* on
the planet, at least inasmuch as it connects ideas drawn from the
media world and OS research/design into a coherent package. Its not
perfect, and we've just started adding new data types to its
capabilities (its actually relatively easy). But it is amazingly
powerful in comparison to anything offered to data, and is
unencumbered by the limitations that have affected other attempts to
do what it does.

And it makes possible some of the most sophisticated *audio* apps on
the planet, though admittedly not video and other data at this time.

>increase as their group and competing projects get more and more
>sophisticated. When I mean kernel folks needs to be proactive, I really
>mean it. The Linux kernel latency issues and poor driver support is
>largely why media apps are way below even being second rate with regard
>to other operating systems such as Apple's OS X for instance.

This is a bit misleading. With the right kernel+patch, Linux performs
at least as well as OSX, and measurably better in many configurations
and cases. And its JACK that has provided OSX with inter-application
audio routing, not the other way around. The higher quality of OSX
apps isn't because of kernel latency or poor driver support: its
because the apps have been under development for longer and have the
immense of benefit of OSX's single unified development
environment. Within the next month, expect to see several important
Linux audio apps released for OSX, providing functionality not
available on that platform at present.

--p

