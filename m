Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132538AbRC1UxZ>; Wed, 28 Mar 2001 15:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132294AbRC1UxP>; Wed, 28 Mar 2001 15:53:15 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:2052 "EHLO bug.ucw.cz") by vger.kernel.org with ESMTP id <S132525AbRC1UxG>; Wed, 28 Mar 2001 15:53:06 -0500
Date: Sun, 25 Mar 2001 23:10:14 +0000
From: Pavel Machek <pavel@suse.cz>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: geirt@powertech.no, linux-kernel@vger.kernel.org
Subject: Re: Serial port latency
Message-ID: <20010325231013.A34@(none)>
References: <000401c0b319517fea9@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <000401c0b319517fea9@local>; from manfred@colorfullife.com on Thu, Mar 22, 2001 at 10:45:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Is the computer otherwise idle?
> I've seen one unexplainable report with atm problems that disappeared
> (!) if a kernel compile was running.

I've seen similar bugs. If you hook something on schedule_tq and forget
to set current->need_resched, this is exactly what you get.
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

