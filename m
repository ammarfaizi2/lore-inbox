Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265914AbUAKRN0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 12:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUAKRN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 12:13:26 -0500
Received: from [130.57.169.10] ([130.57.169.10]:49817 "EHLO peabody.ximian.com")
	by vger.kernel.org with ESMTP id S265914AbUAKRNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 12:13:24 -0500
Subject: Re: Laptops & CPU frequency
From: Robert Love <rml@ximian.com>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1Afj2b-0004QN-00@chiark.greenend.org.uk>
References: <20040111025623.GA19890@ncsu.edu>
	 <20040111025623.GA19890@ncsu.edu> <1073791061.1663.77.camel@localhost>
	 <E1Afj2b-0004QN-00@chiark.greenend.org.uk>
Content-Type: text/plain
Message-Id: <1073841200.1153.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sun, 11 Jan 2004 12:13:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-11 at 12:06, Matthew Garrett wrote:

> Is this true even when the speed changes aren't done through Speedstep?
> Some older (PII/non-Speedstep PIIIs) Thinkpads automatically change
> speed based on presence of AC power, but do it in a way that's exposed
> as an ACPI throttling state rather than a performance state. My
> experience is that this doesn't result in cpuinfo getting updated, and
> various kernel things seem to become unhappy. On the other hand, I
> haven't tried this since 2.5.5something - I just told the BIOS not to
> touch stuff instead.

No - if the laptop changes speed on its own, using a system that Linux
does not understand, then Linux won't know about the change,
/proc/cpuinfo will not be updated, and stuff won't go too good.

	Robert Love


