Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWEVJ35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWEVJ35 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 05:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWEVJ35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 05:29:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5858 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750725AbWEVJ34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 05:29:56 -0400
Date: Mon, 22 May 2006 11:29:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA] Poor man's UPS
Message-ID: <20060522092915.GA25624@elf.ucw.cz>
References: <200605212131.47860.pgquiles@elpauer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605212131.47860.pgquiles@elpauer.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is an idea a had some time ago. It might be a waste of time or it might 
> be a good idea, you decide.

Well, it depends on "are you willing to work on it"?

> The "continuous hibernation" is some kind of memory snapshots taken, say, 
> every 5 minutes. The next time your system starts after a crash, it'd say "oh 
> oh, looks like something went wrong" and offer you a list of the last N (for 
> instance, 4) snapshots and you can recover your system to the very same state 
> it was before power went off or your dog unplugged your CPU. It might even 
> ask you which individual applications you want to start from that snapshot:  
> maybe you don't want to start Quake 3.

See suspend.sf.net and probably dm snapshotting functionality. Most of
what you want can be done today, and in userspace.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
