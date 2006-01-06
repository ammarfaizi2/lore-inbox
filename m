Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWAFBlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWAFBlu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWAFBlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:41:50 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:35773 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932411AbWAFBlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:41:49 -0500
Date: Thu, 5 Jan 2006 20:41:40 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: David Lang <dlang@digitalinsight.com>
Cc: Dave Jones <davej@redhat.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-ID: <20060106014140.GG5516@filer.fsl.cs.sunysb.edu>
References: <20060105045212.GA15789@redhat.com> <Pine.LNX.4.61.0601050907510.10161@yvahk01.tjqt.qr> <20060105103339.GG20809@redhat.com> <Pine.LNX.4.62.0601051722110.973@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0601051722110.973@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 05:24:01PM -0800, David Lang wrote:
> On Thu, 5 Jan 2006, Dave Jones wrote:
> 
> >> (*) If the oops is longer than 25 lines, ... you can't even use 
> >scrollback
> >> because scrollback is cleared when you change consoles. X runs by default
> >> on tty7, and the kernel dumps it somewhere else. (And even if it dumped 
> >to
> >> tty7 directly, you would not see it.)
> >
> >What to do about oopses whilst in X has been the subject of much
> >head-scratching for years now.  It's come up at least at the
> >last two kernel summits, and I'll hazard a guess it'll come up
> >again this year.  The amount of work necessary to make it all
> >work on both kernel side and X side isn't unsubstantial however,
> >so I wouldn't count on it working too soon.
> 
> hmm, if you can hope that someone will grab a camera to report an oops, 
> how about them grabbing a tape recorder/mp3 recorder to record audio from 
> the speaker. it's not fast, but you don't have that much data to output, 
> do it in morse (with the audio explination of what's going to happen 
> first)

There is a patch somewhere that uses the keyboard lights to "display" panics,
and a comment that the PC speaker implementation is left up to the reader :)

It shouldn't be hard do, then all you need is just one printk telling the user
to record it :)

Jeff.
