Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUEZXvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUEZXvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 19:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUEZXvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 19:51:54 -0400
Received: from amber.ccs.neu.edu ([129.10.116.51]:17623 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S261231AbUEZXvw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 19:51:52 -0400
Subject: Re: Bad X-performance on 2.6.6 & 2.6.7-rc1 on x86-64
From: Stan Bubrouski <stan@ccs.neu.edu>
To: MalteSch@gmx.de
Cc: Andi Kleen <ak@muc.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040526122658.2121389e@highlander.Home.LAN>
References: <1ZqbC-5Gl-13@gated-at.bofh.it>
	 <m3r7t9d3li.fsf@averell.firstfloor.org>
	 <20040525122659.395783f4@highlander.Home.LAN>
	 <20040525123636.GA13817@colin2.muc.de> <1085520021.1393.4168.camel@duergar>
	 <20040526122658.2121389e@highlander.Home.LAN>
Content-Type: text/plain; charset=utf-8
Message-Id: <1085615502.4543.26.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 26 May 2004 19:51:43 -0400
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-26 at 06:26, Malte Schröder wrote:
> > And Malte, are you using emu10k1 driver per chance?
> Yes, emu10k1/alsa on sb audigy.

I asked because I'm using the emu10k1 driver and I've noticed frequent
bizarre behviour when watching videos in xine AND mplayer...

While this could be written off as a xine bug, my friends who have other
audio cards can watch the same files without issue in both media
players.  I hadn't thought much of it, until now.

So here's the low-down... I'm thinking there are some bad bugs in the
emu10k1 driver (not surprisingly, it's given me problems for *4* years,
using OSS and ALSA, though I must say the OSS driver seems to be ALOT
better).

For completeness could you test the OSS emu10k driver (which supports
PCM, while the ALSA driver does not) and see if you experience better
overall performance?  Like less CPU utilization etc... I'm very
interested in finding out where the bottlenecks are.  The emu10k1 driver
isn't perfect and neither are xine or mplayer so I'd like figure out
what  exactly  is going on here.  I'll of course do the same.  It's just
kind of hard to judge for me seeing as my system is now 4 years old.

-sb

