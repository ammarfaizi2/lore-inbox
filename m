Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263084AbRFJLHT>; Sun, 10 Jun 2001 07:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264517AbRFJLHJ>; Sun, 10 Jun 2001 07:07:09 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:4356 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S263084AbRFJLGy>;
	Sun, 10 Jun 2001 07:06:54 -0400
Message-ID: <20010609102936.A660@bug.ucw.cz>
Date: Sat, 9 Jun 2001 10:29:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org,
        xgajda@fi.muni.cz, kron@fi.muni.cz
Subject: Re: CacheFS
In-Reply-To: <20010607133750.I1193@informatics.muni.cz> <20010607114419.A23962@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010607114419.A23962@cs.cmu.edu>; from Jan Harkes on Thu, Jun 07, 2001 at 11:44:19AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > * Can the kernel part of CODA can be used for this?
> 
> Not if you want to intercept and redirect every single read and write
> call. That's a whole other can of worms, and I'd advise you to let the
> userspace cachemanager to act as an NFS daemon. In my opinion, the Coda
> kernel module fills a specific niche, and should not become yet another
> kernel NFS client implementation that happens to bounce requests to
> userspace using read/write on a character device instead of RPC/UDP
> packets to a socket.

Forget NFS if you want it to be read/write. There are nasty deadlocks
out there.

> AVFS,
>     Another userfs implementation that when from a shared library hack
>     to using the Coda kernel module,
> 
>     http://sourceforge.net/projects/avfs

avfs moved to sourceforge? Wow!
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
