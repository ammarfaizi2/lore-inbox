Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUEYVXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUEYVXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265090AbUEYVXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:23:38 -0400
Received: from amber.ccs.neu.edu ([129.10.116.51]:46995 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S265087AbUEYVXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:23:37 -0400
Subject: Re: Bad X-performance on 2.6.6 & 2.6.7-rc1 on x86-64
From: Stan Bubrouski <stan@ccs.neu.edu>
To: Andi Kleen <ak@muc.de>
Cc: Malte Schr?der <MalteSch@gmx.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040525123636.GA13817@colin2.muc.de>
References: <1ZqbC-5Gl-13@gated-at.bofh.it>
	 <m3r7t9d3li.fsf@averell.firstfloor.org>
	 <20040525122659.395783f4@highlander.Home.LAN>
	 <20040525123636.GA13817@colin2.muc.de>
Content-Type: text/plain
Message-Id: <1085520021.1393.4168.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 25 May 2004 17:20:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-25 at 08:36, Andi Kleen wrote:
> On Tue, May 25, 2004 at 12:26:59PM +0200, Malte Schr?der wrote:
> > New information :)
> > I didn't profile it yet but I think I found what caused the problem.
> > It turned out that I have to disable alsa mmap-support in xine (mplayer worked w/o problems, it does not offer alsa mmap), so X is not involved at all. Do you still need a profile or is this a known thing?
> 
> Ask the xine guys if it's known, I don't know much about xine.
> If a user space change fixes it then I don't need any profiles.
> 

I can confirm that xine with alsa-mmap option set does cuase strange
behaviour, though I notice it mostly as audio and video getting out of
sync when playing videos.  I've noticed this behaviour since I started
doing weekly xine CVS builds.  I've never bothered reporting it however,
I just turned off the option... which leads me to my question, what is
the advantage of using alsa-mmap in an app if it is used correctly?

And Malte, are you using emu10k1 driver per chance?

-sb

> -Andi


