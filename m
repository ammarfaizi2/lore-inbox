Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132163AbRDDURv>; Wed, 4 Apr 2001 16:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132145AbRDDURm>; Wed, 4 Apr 2001 16:17:42 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:23300 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S132143AbRDDURc>;
	Wed, 4 Apr 2001 16:17:32 -0400
Date: Mon, 2 Apr 2001 14:26:02 +0000
From: Pavel Machek <pavel@suse.cz>
To: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ethernet driver tweak for error correction codes
Message-ID: <20010402142601.A34@(none)>
In-Reply-To: <20010328232059.A1570@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010328232059.A1570@atrey.karlin.mff.cuni.cz>; from clock@atrey.karlin.mff.cuni.cz on Wed, Mar 28, 2001 at 11:20:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Is it possible to use up the src, dest MAC addresses (12B) and the CRC field (4B?)
> on a point-to-point full duplex Ethernet link for my own data?

That does not seem like too clean solution.

> I would like to implement an error correction on this, because I'm gonna build
> a freespace laser link which would run just this way. And i want to use it on
> foggy days too when there will be a lot of bits fallen out.
> 
> Is it possible to do it in the kernel somehow cleanly? How should I try to do it?

Do it userspace: hook slip on tty/pty pair. See scarabd for details.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

