Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285361AbRLNNNt>; Fri, 14 Dec 2001 08:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285365AbRLNNNj>; Fri, 14 Dec 2001 08:13:39 -0500
Received: from mustard.heime.net ([194.234.65.222]:17312 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S285363AbRLNNNW>; Fri, 14 Dec 2001 08:13:22 -0500
Date: Fri, 14 Dec 2001 14:12:55 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] RAID sub system
In-Reply-To: <Pine.LNX.4.33.0112131525470.15231-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.30.0112141409000.6035-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > ...and so on
> >
> > This gives a total read of a little less than 800MB before giving up. Is
> > there a cache timeout that needs to be set any lower?
>
> my observation is this: once you use up all your free memory, you have
> 30 seconds of reasonable behavior.  30 seconds is the the default dirty-buffer
> age.  are you tweaking /proc/sys/vm/bdflush at all?  and no, I don't see
> why your application would have dirty buffers in the first place -
> I'm just noticing the ominous 30 seconds.

no bdflush tweaking...

this is the same as I've observed... Usa all memory, and everything stops
up.

> are you using elvtune?

er.. what's elvtune?

> also, which kernel?

2.4.16 + tux patches

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


