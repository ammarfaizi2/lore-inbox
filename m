Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265378AbUAKRGX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 12:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265436AbUAKRGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 12:06:23 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:3278 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S265378AbUAKRGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 12:06:22 -0500
To: linux-kernel@vger.kernel.org
Cc: rml@ximian.com
Subject: Re: Laptops & CPU frequency
In-Reply-To: <1073791061.1663.77.camel@localhost>
References: <20040111025623.GA19890@ncsu.edu> <20040111025623.GA19890@ncsu.edu> <1073791061.1663.77.camel@localhost>
Message-Id: <E1Afj2b-0004QN-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Date: Sun, 11 Jan 2004 17:06:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

>The MHz value in /proc/cpuinfo should be updated as the CPU speed
>changes - that is, it is not calculated just at boot, but it is updated
>as the speed actually changes.

Is this true even when the speed changes aren't done through Speedstep?
Some older (PII/non-Speedstep PIIIs) Thinkpads automatically change
speed based on presence of AC power, but do it in a way that's exposed
as an ACPI throttling state rather than a performance state. My
experience is that this doesn't result in cpuinfo getting updated, and
various kernel things seem to become unhappy. On the other hand, I
haven't tried this since 2.5.5something - I just told the BIOS not to
touch stuff instead.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
