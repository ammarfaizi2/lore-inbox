Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263504AbTLJNNc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 08:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTLJNNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 08:13:32 -0500
Received: from secure.comcen.com.au ([203.23.236.73]:3845 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S263504AbTLJNN3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 08:13:29 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Jesse Allen <the3dfxdude@hotmail.com>
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Wed, 10 Dec 2003 19:22:57 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, AMartin@nvidia.com
References: <200312072312.01013.ross@datscreative.com.au> <20031210033906.GA176@tesore.local>
In-Reply-To: <20031210033906.GA176@tesore.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312101922.57228.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 December 2003 13:39, Jesse Allen wrote:
> Hi Ross,
> 
> I have rediffed your two patches for vanilla 2.6.0-test11.  Briefly, I tried the apic patch first, and found that there are no lockups so far; well it passed my grep tests and even a kernel compile =).  Then I tried your io_apic patch + apic patch.  With nmi_watchdog=1 "NMI:" in /proc/interrupts increments alot compared to nmi_watchdog=2 before (as much as the timer).  So I believe your two patches are more correct than the other two.  Especially the fact I can run with CPU Disconnect and not lock up just like windows ... for people that have windows (I dont have windows =) plus a probably working nmi_watchdog.
> 
> And for comparison, my setup:
> Shuttle AN35N Ultra v 1.1  (Nforce2 400 ultra), bios updated
> Athlon Barton 2600+ (1.9 Ghz)
> 256 MB PC3200, single stick.
> 
> The patches are included in this mail.  I suppose the next thing to do is get out of nvidia the corresponding information.  And then clean up the patch for inclusion.
> 
> Jesse
> 
> 
> 
Thank Jesse
It is interesting that the lockup problems also occur with a single memory stick,
I have only tried dual sticks.
Regards
Ross.
