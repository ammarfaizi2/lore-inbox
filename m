Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbUKKAHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbUKKAHS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 19:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbUKKAHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 19:07:15 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:2191 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262154AbUKKAGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 19:06:43 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, Alexandre Costa <alebyte@gmail.com>
Subject: Re: DEVFS_FS
Date: Wed, 10 Nov 2004 19:06:37 -0500
User-Agent: KMail/1.7
Cc: linux-os@analogic.com
References: <Pine.LNX.4.61.0411101544080.19616@chaos.analogic.com> <543d091304111013035563e7f6@mail.gmail.com>
In-Reply-To: <543d091304111013035563e7f6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411101906.37328.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.37.139] at Wed, 10 Nov 2004 18:06:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 November 2004 16:03, Alexandre Costa wrote:
>On Wed, 10 Nov 2004 15:46:06 -0500 (EST), linux-os
>
><linux-os@chaos.analogic.com> wrote:
>> What is the approved substitute for DEVFS_FS that is marked
>> obsolete?
>
>udev
>http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html

Humm, I'm not sure I'm entirely happy with that choice.  I have an 
FC3RC5 install on an old P-II running at 233mhz, and the udev start 
in the bootup is the slowest single thing to get started by an order 
of magnitude.

Can someone tell me a good reason udev wastes as much time as the post 
does checking 383 megs of memory, which is very nearly a minute even 
just for udev?

If its to be used, its got to speed itself up, a LOT!.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
