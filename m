Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280989AbRKLVHC>; Mon, 12 Nov 2001 16:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280990AbRKLVGw>; Mon, 12 Nov 2001 16:06:52 -0500
Received: from zok.SGI.COM ([204.94.215.101]:37043 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S280989AbRKLVGi>;
	Mon, 12 Nov 2001 16:06:38 -0500
Message-ID: <3BF039D9.D75809F2@sgi.com>
Date: Mon, 12 Nov 2001 13:06:33 -0800
From: L A Walsh <law@sgi.com>
Organization: Trust Technology, Core Linux, SGI
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: "mike@morpheus" <mike@morpheus.streamgroup.co.uk>
CC: Linux-kernel@vger.kernel.org
Subject: Re: mysterious power off problem 2.4.10-2.4.14 on laptop
In-Reply-To: <Pine.LNX.4.33.0111122227140.24454-100000@morpheus.streamgroup.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"mike@morpheus" wrote:
> Give ACPI a try, for a while I've noticed APM getting mixed up
> on my home box (its a VIA chipset, I've been told that probably
> why :), doing things like not powering off and changing the instant-off
> powerbutton to a wait-5-seconds powerbutton.
> 
> I switched to ACPI and everythings been working fine :)
---
	Thanks for the suggestion.  However APM was working superbly for
my architecture in 2.4.9 and before.  It turned off the display when I
wasn't using it.  It occasionally spun down disks w/the help of noflushd,
and when suspend was indicated, it correctly suspended to RAM where it
can stay for hours using <1%/hour.  

	I did try ACPI at some point, but it didn't work as well in
providing the same features and reliability when I tested it.  The
config option says "Experimental", ACPI isn't a feature complete as
APM and ACPI was in development.  It might work differently on different
hardware, for example.  While it is to be the replacement for APM, I
don't know if I am comfortable moving to it yet -- and even so, why should
APM mysteriously break when it has been working great since the early 
2.4 series and fairly well since 2.2 (X was a problem on my hardware at one
point).

	I'd prefer not to try an unknown, where if I have a problem, I
don't know if it is my hardware, a misconfiguration on my part, or the
Experimental Hardware.  That would likely take more time than simply
staying with APM -- a known 'working configuration', and finding what
changed in 2.4.10 (and remains in 2.4.14) that lead to the new problems.

	If it worked before, then something changed in the kernel to
break it, I'd generally classify that as a bug.  Now maybe there
are new utilities needed -- however, in SuSE 7.3, they use the 2.4.10
kernel and their default setup has the same problem.

:-(
-linda
