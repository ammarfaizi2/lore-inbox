Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264499AbUFSQ3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbUFSQ3I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUFSQ07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:26:59 -0400
Received: from [80.72.36.106] ([80.72.36.106]:5510 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S264542AbUFSQZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:25:59 -0400
Date: Sat, 19 Jun 2004 18:25:48 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-ck1
In-Reply-To: <40D3CE68.2000403@kolivas.org>
Message-ID: <Pine.LNX.4.58.0406191824030.4764@alpha.polcom.net>
References: <200406162122.51430.kernel@kolivas.org>
 <1087576093.2057.1.camel@teapot.felipe-alfaro.com>
 <Pine.LNX.4.58.0406182004370.32121@alpha.polcom.net> <200406191406.45750.kernel@kolivas.org>
 <40D3CE68.2000403@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Jun 2004, Con Kolivas wrote:

> Con Kolivas wrote:
> > On Sat, 19 Jun 2004 04:35, Grzegorz Kulewski wrote:
> > 
> >>Hi Con,
> >>
> >>I have two problems with 2.6.7-ck1. My distribution is Gentoo Linux
> >>unstable with all latest updates. Oh, yes, both 2.6.7-ck1 and 2.6.7-rc3
> >>I tested have vesafb-tng applied from http://dev.gentoo.org/~spock/, but
> >>it should not cause any problems because it is very non-intrusive patch I
> >>think. Maybe you should include this in your patchset?
> >>
> >>1. When booting init script freezes after starting input hotplugging (it
> >>is udev system). The only way to make it run is to press Ctrl-Alt-SysRQ
> >>and various keys to display kernel state several times. After that system
> >>starts normally. I do not know if it is only -ck problem because I had
> >>no time to test 2.6.7 vanilla, but 2.6.7-rc3 worked fine. (Log included.)
> > 
> > 
> > Yes I have a sneaking suspicion it's related to the fact kernel threads are 
> > fixed priority at the moment in staircase (they dont descend priority like 
> > normal tasks so act like relatively low priority real time tasks). I'm 
> > addressing that for the next version so hopefully that will fix it.
> 
> Here's a diff for -ck1 which brings you up to staircase7.1
> Can you try that?

It does not solve the problem for me, sorry...


Thanks,

Grzegorz Kulewski

