Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVBRVX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVBRVX0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 16:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVBRVX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 16:23:26 -0500
Received: from mail1.kontent.de ([81.88.34.36]:22741 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261484AbVBRVXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 16:23:22 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6: drivers/input/power.c is never built
Date: Fri, 18 Feb 2005 22:23:19 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@suse.cz>, dtor_core@ameritech.net,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <047401c515bb$437b5130$0f01a8c0@max> <20050218202443.GB1403@elf.ucw.cz> <20050218204018.GA2760@ucw.cz>
In-Reply-To: <20050218204018.GA2760@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502182223.19896.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 18. Februar 2005 21:40 schrieb Vojtech Pavlik:

> I wouldn't want to pass all the battery info (UPSes can be even more
> complex, able to switch on/off individual sockets, etc) through input,
> just the basic events:
> 
> 	AC power on/off
> 	battery full/normal/low/critical/(fail)
> 
> Then the other power-related events
> 
> 	Lid open/closed
> 	Power button
> 	Sleep button

What is the benefit of splitting the flow of information so?

> I think that's all you need to trigger actions. You don't need the exact
> percentage of the battery, and you don't need the exact AC voltage at
> input. 

That is very debateable. I might want a quiet mode and would be
interested in notifications about thermal data and fan status. 

	Regards
		Oliver
