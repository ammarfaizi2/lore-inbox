Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVH3I3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVH3I3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 04:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVH3I3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 04:29:04 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:50984 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751228AbVH3I3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 04:29:02 -0400
Date: Tue, 30 Aug 2005 10:29:01 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Sven Ladegast <sven@linux4geeks.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050830082901.GA25438@bitwizard.nl>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 10:01:21AM +0200, Sven Ladegast wrote:
> The idea isn't bad but lots of people could think that this is some kind 
> of home-phoning or spy software. I guess lots of people would turn this 
> feature off...and of course you can't enable it by default. But combined 
> with an automatic oops/panic/bug-report this would be _very_ useful I think.

It IS some "home phoning" and "spy software". However, when the 
goal is to sign you up for more direct marketing, people tend to 
object. When the goal is to keep track of running kernels, I'm
hopeful that people will recognise that this is different. 

A trick to use would be to send an UDP packet at boot (after 1 minute 
or so), and then randomly say "once a month" (i.e. about 1/30 chance of 
sending a packet on the first day) The number of these random packets
recieved is a measure of the number of CPU-months that the kernel
runs. 

	Roger. 

--
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
