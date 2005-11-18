Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbVKRXjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVKRXjG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 18:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVKRXjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 18:39:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3985 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751182AbVKRXjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 18:39:04 -0500
Date: Fri, 18 Nov 2005 23:20:20 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: bart@samwel.tk, linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
Message-ID: <20051118232019.GA2359@spitz.ucw.cz>
References: <20051116181612.GA9231@knautsch.gondor.com> <20051117223340.GD14597@elf.ucw.cz> <437E215E.30500@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437E215E.30500@tmr.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Can you try some filesystem test while forcing disk spindowns via
> >hdparm?
> >
> >It may be bug in laptop mode, or a bug in ide (or something
> >related)... trying spindowns without laptopmode would be helpful.
> >
> I don't know if it would be helpful, but I run several servers with 
> multiple drives, usually 4-5, some of which are in RAID and some aren't, 
> and they all spin down and restart without problems many times a day. 
> The kernel is 2.6.14.? with one patch to get my unsupported VIA IDE working.
> 
> My laptop also has a spindown (five min from memory) and I have yet to 
> have a problem with it. Don't know if any of that is "spindowns without 
> laptopmode" in a useful sense.

Unless you can also reproduce the failure... no, probably does not help
much.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

