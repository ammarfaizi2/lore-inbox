Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264269AbUD0SvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbUD0SvF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbUD0SvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:51:05 -0400
Received: from dsl-hkigw3hb0.dial.inet.fi ([80.222.39.176]:42525 "EHLO
	mail.sonarnerd.net") by vger.kernel.org with ESMTP id S264269AbUD0SvD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:51:03 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Jussi Laako <jussi@sonarnerd.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1083088854.2322.38.camel@dhcppc4>
References: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl>
	 <1083088854.2322.38.camel@dhcppc4>
Content-Type: text/plain
Message-Id: <1083091888.18016.11.camel@vaarlahti.uworld>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 27 Apr 2004 21:51:28 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 21:00, Len Brown wrote:

> I run "optimized defaults", I don't overclock anything.
> Processor is an AMD XP 2200+
> Does anybody else see the hang with this processor model?
> I wonder if the hang is processor model or speed dependent?

Have people run memtest86 over weekend without errors?

I found nForce2 (newer ones, rev2? A7N8X rev 2 and K7N2 Delta) to be
veery picky to DDR400 RAMs. I was able to find 2 properly working memory
modules out of 6. Also tested with several different brands. However
A7N8X rev 1 runs fine without need for carefully picking memory modules.

Memory test may need to be run over 48 hours to detect errors. But the
time required may be lower when running Linux kernel.


-- 
Jussi Laako <jussi@sonarnerd.net>

