Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbUCFMn7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 07:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbUCFMnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 07:43:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21418 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261661AbUCFMm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 07:42:58 -0500
Date: Fri, 5 Mar 2004 23:09:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Steve Longerbeam <stevel@mvista.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: new special filesystem for consideration in 2.6/2.7
Message-ID: <20040305220950.GA5352@openzaurus.ucw.cz>
References: <40462AA1.7010807@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40462AA1.7010807@mvista.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> (PRAMFS). It was originally developed for three major consumer
> electronics companies for use in their smart cell phones
> and other consumer devices.
> 
> An intro to PRAMFS along with a technical specification
> is at the SourceForge project web page at
> http://pramfs.sourceforge.net/. A patch for 2.6.3 has
> been released at the SF project site.

Well, I'd certainly love to see some usable linux cell phones. 
(Well, one such beast in my pocket would probably be enough :-)
(Is there a way to make linux cell phone without second
cpu just for GSM stack?)

Comments about pramfs: RAM is not really random access,
you'll find that doing byte-sized random reads is way slower
than linear read,
but you are right that it is very different from disk.

How do you handle powerfail in the middle of write?
Do you run fsck or do you have some kind of logging?


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

