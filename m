Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbTEILnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 07:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTEILnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 07:43:19 -0400
Received: from gate.perex.cz ([194.212.165.105]:39429 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S262496AbTEILnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 07:43:17 -0400
Date: Fri, 9 May 2003 13:55:16 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Christoph Hellwig <hch@lst.de>
Cc: "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       "torvalds@transmeta.com" <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove unused funcion proc_mknod
In-Reply-To: <20030509134714.A3837@lst.de>
Message-ID: <Pine.LNX.4.44.0305091355080.1237-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 May 2003, Christoph Hellwig wrote:

> On Fri, May 09, 2003 at 01:43:20PM +0200, Jaroslav Kysela wrote:
> > alsa-lib doesn't rely on it at all. The devices in /dev/snd/ might be 
> > created in these ways:
> > 
> > 1) static - using the mknod command
> > 2) using devfs
> > 3) link /dev/snd to /proc/asound/dev
> > 
> > We prefered the third solution because we were changing heavily the device
> > minor numbers in the past. We can remove the proc dynamic device creating
> > from our code now. I agree, this code should not be in the kernel tree.
> 
> Okay.  Will you submit the removal as part of the next alsa merge?

Sure. I'll do it ASAP.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

