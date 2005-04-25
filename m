Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVDYUci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVDYUci (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVDYUcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:32:12 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:15245 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261171AbVDYU3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:29:24 -0400
Date: Mon, 25 Apr 2005 16:29:21 -0400
To: Randy Gardner <lkml@bushytails.net>
Cc: unlisted-recipients: no@csclub.uwaterloo.ca, To-header@csclub.uwaterloo.ca,
       on@csclub.uwaterloo.ca, "input <"@csclub.uwaterloo.ca,
       ;;;linux-kernel@vger.kernel.org;
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	;linux-kernel@vger.kernel.org
			^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	;linux-kernel@vger.kernel.org
			^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
Subject: Re: ide-cd?  Can burn DVDs, just not read them...
Message-ID: <20050425202921.GB15693@csclub.uwaterloo.ca>
References: <426972E5.4000408@bushytails.net> <20050425163436.GA15693@csclub.uwaterloo.ca> <426D2F03.2040001@bushytails.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426D2F03.2040001@bushytails.net>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 10:55:15AM -0700, Randy Gardner wrote:
> Don't have an easy way to test that; I'd have to take it back to the 
> person with a dual-boot box, as I'm pretty sure their update utility is 
> a windoze bianry...

You should be able to see the firmware version using one of the cd
writing tools (cdrecord or dvd+rw-mediainfo or whichever).  Comparing to
what the manufacturer has on offer could at least tell that.  As for
updating, if it isn't a plextor it almost certainly requries windows
and/or dos to update (usually windows it seems).

> But, since problems are also happening with my cd-rw drive (even with 
> the dvd-rw out of the system), which I know worked before, I don't think 
> it's a drive problem.

Well that does sound odd.  Is this your own kernel build from plain
kernel.org sources or are there any patches involved?

> Originally it shared a cable with my cd-rw drive, but I've tried it both 
> on its own cable and sharing with one of my hard drives, on both the 
> ata/66 controller and the ata/100 raid controller, with no changes at all.

As far as I know, promise cards are only recommended for harddisks, but
I am not sure of that.  I have only ever used them for harddisks myself.

> 80 conductor cables for all tests.  I might be able to dig up a 40 
> conductor one for testing, but I don't think that'll help...

Different cables tried?  Just in case you have a bad cable in there?

> Someone suggested I try a binary search of kernel versions to figure out 
> exactly when the cd-rw drive was broken (which worked before, unlike the 
> dvd, which I have no idea if it ever worked), in an effort to figure out 
> what caused it to break...  going to try this, but haven't had the 
> time...  a long project.  :)

Sounds painful.

Well so far I have had no problems reading or writing with 2.6.11,
2.6.10, 2.6.8, and some earlier 2.6 kernels (all Debian sarge or sid
builds).  

Len Sorensen
