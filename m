Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263149AbVGaArF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbVGaArF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 20:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbVGaArF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 20:47:05 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31694 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263149AbVGaAqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 20:46:19 -0400
Subject: Re: Simple question re: oops
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Alexander Nyberg <alexn@telia.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e997050730174034a68f4@mail.gmail.com>
References: <1122767292.4464.1.camel@mindpipe>
	 <20050731001101.GA6762@localhost.localdomain>
	 <1122769290.4464.12.camel@mindpipe>
	 <21d7e997050730174034a68f4@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 30 Jul 2005 20:46:17 -0400
Message-Id: <1122770777.5473.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-31 at 10:40 +1000, Dave Airlie wrote:
> > panic_on_oops has no effect, a bunch of stuff flies past and the last
> > thing I see is "gam_server: scheduling while atomic" then a stack trace
> > of the core dump path then "Aiee, killing interrupt handler".
> > 
> > I am starting to suspect the hard drive, does that sound plausible?
> > It's as if it locks up when it hits a certain disk block.
> 
> run memtest on it... you might have bad RAM..
> 

Already swapped it out, but I'll try memtest.

Any idea why printk_ratelimit does not work?  I set it to 1000 (per the
docs this should limit to 1 printk per second) and burst to 1 but I
still get screenfuls of text flying by.

Lee


