Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265790AbUAKGQg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 01:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265791AbUAKGQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 01:16:36 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:12804 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265790AbUAKGQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 01:16:35 -0500
Date: Sun, 11 Jan 2004 07:16:29 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Robert Love <rml@ximian.com>
Cc: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org
Subject: Re: Laptops & CPU frequency
Message-ID: <20040111061629.GF545@alpha.home.local>
References: <20040111025623.GA19890@ncsu.edu> <1073791061.1663.77.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073791061.1663.77.camel@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 10:17:41PM -0500, Robert Love wrote:
 
> You probably have some issue in your power management scripts - Fedora
> should scale the CPU speed back as soon as you remove AC power, not just
> at boot if not on AC.

I never understood why the speed depends on AC power (except to fake a long
autonomy). It would be smarter if it scaled the speed based on CPU usage.
It's what I did on my notebook (athlon 1.3G), and I'm happy to run it all
the day at 500 MHz and not to hear its stupid CPU fan dancing every minute,
and I too am happy to be able to compile a kernel in 3 minutes even on
battery, when it would take 10 min at 500 MHz and eat the battery much more,
since LCD and disk eat power during 7 more minutes.

Just my thought...

Cheers,
Willy

