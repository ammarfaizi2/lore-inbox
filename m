Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVALPoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVALPoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 10:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVALPoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 10:44:32 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:758 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261226AbVALPo1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 10:44:27 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None, usuallly detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11-rc1
Date: Wed, 12 Jan 2005 10:44:25 -0500
User-Agent: KMail/1.7
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org> <200501121824.44327.rathamahata@ehouse.ru> <Pine.LNX.4.58.0501120730490.2373@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501120730490.2373@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501121044.25474.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.42.99] at Wed, 12 Jan 2005 09:44:26 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 January 2005 10:32, Linus Torvalds wrote:
>On Wed, 12 Jan 2005, Sergey S. Kostyliov wrote:
>> 2.6.10-rc1 hangs at boot stage for my dual opteron machine
>
>Oops, yes. There's some recent NUMA breakage - either disable
> CONFIG_NUMA, or apply the patches that Andi Kleen just posted on
> the mailing list (the second option much preferred, just to verify
> that yes, that does fix it).
>
>  Linus

I also have a minor breakage, I've been using the forcedeth module for 
my networking, and it apparently isn't being autoloaded with this 
version.  However, once booted, I can insmod it, and 'service network 
start' and it appears to be ok then.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
