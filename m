Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319226AbSH2KEG>; Thu, 29 Aug 2002 06:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319227AbSH2KEF>; Thu, 29 Aug 2002 06:04:05 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:31145 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S319226AbSH2KEF>; Thu, 29 Aug 2002 06:04:05 -0400
Date: Thu, 29 Aug 2002 12:23:31 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Cort Dougan <cort@fsmlabs.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Dominik Brodowski <devel@brodo.de>, <cpufreq@www.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
In-Reply-To: <20020828124839.F5492@host110.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0208291222240.13929-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2002, Cort Dougan wrote:

> It's even worse for some of the very new P4's that don't have their
> heatsink seated properly.  They heat up every few minutes and then throttle
> themselves due to thermal overload.  I think this situation is going to
> become more and more common, now.  We're at the mercy of every BIOS and
> micro-code programmer now-a-days.  That situation needs to be improved
> upon, as well.

The P4 clock modulation driver was aware of that condition and in fact the 
processor would not allow changing the speed in a thermal throttled state 
anyway.

	Zwane

-- 
function.linuxpower.ca

