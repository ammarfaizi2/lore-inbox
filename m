Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288733AbSADThl>; Fri, 4 Jan 2002 14:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288732AbSADThc>; Fri, 4 Jan 2002 14:37:32 -0500
Received: from lsanca1-ar27-4-63-187-072.vz.dsl.gtei.net ([4.63.187.72]:4736
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S288737AbSADThV>; Fri, 4 Jan 2002 14:37:21 -0500
Date: Fri, 4 Jan 2002 11:37:11 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Doug Ledford <dledford@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: i810_audio]
In-Reply-To: <3C35CCB1.8040900@redhat.com>
Message-ID: <Pine.LNX.4.33.0201040929060.1742-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ben Clifford wrote:

> Your particular report sounds like the recording bugs that have already been
> fixed by my 0.13 version of the driver.  Please download that and see if
> recording works better for you.  It can be found at
> http://people.redhat.com/dledford/i810_audio.c.gz

I dumped that into my kernel source directory - it seems to have pretty
much inverted the problem:
rec now doesn't crash.

However, playback *does* now crash the machine.

It crashes at the same time as rec was crashing, at the end of the
playback, although this time it locks up on something as simple as:

cat anything > /dev/dsp

It manages to display the shell prompt again before crashing.

Its been several years since I attempted to do any kernel debugging - can
someone advise what I can do to get more info?

Ben

-- 
Ben Clifford     benc@hawaga.org.uk
http://www.hawaga.org.uk/ben/  GPG: 30F06950
telnet/ssh guest@barbarella.hawaga.org.uk password guest to talk
webcam: http://barbarella.hawaga.org.uk/benc-cgi/watchers.cgi
Job Required - Will do most things unix or IP for money.




