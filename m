Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbRFMJd5>; Wed, 13 Jun 2001 05:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbRFMJdt>; Wed, 13 Jun 2001 05:33:49 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6916 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S262436AbRFMJdf>;
	Wed, 13 Jun 2001 05:33:35 -0400
Date: Tue, 12 Jun 2001 16:12:38 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3com Driver and the 3XP Processor
Message-ID: <20010612161237.C33@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.30.0106111918550.8612-100000@biglinux.tccw.wku.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0106111918550.8612-100000@biglinux.tccw.wku.edu>; from brent@biglinux.tccw.wku.edu on Mon, Jun 11, 2001 at 07:24:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I just had one of the "3com Etherlink 10/100 PCI NIC with 3XP processor"
> float accross my desk, I was wondering how much the linux kernel uses the
> 3xp processor for its encryption offloading and such.  According to the
> hype it does DES without using the CPU, does linux take advantage of that?

Doing DES is uninteresting these days...

That feature is useless --- everything but IPsec does encryption at
application layer where NIC can not help.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

