Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266490AbUHBReO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbUHBReO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 13:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266670AbUHBReO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 13:34:14 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:4114
	"EHLO muru.com") by vger.kernel.org with ESMTP id S266490AbUHBReM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 13:34:12 -0400
Date: Mon, 2 Aug 2004 10:34:01 -0700
From: Tony Lindgren <tony@atomide.com>
To: Andi Kleen <ak@muc.de>
Cc: linuxkernellist@wonderclown.com, linux-kernel@vger.kernel.org
Subject: Re: MSI K8N Neo + powernow-k8: ACPI info is worse than BIOS PST
Message-ID: <20040802173401.GA816@atomide.com>
References: <2o2IK-8gu-7@gated-at.bofh.it> <2oI5h-3A8-7@gated-at.bofh.it> <m3n01dso1i.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3n01dso1i.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.3.28i
X-Mailer: Mutt http://www.mutt.org/
X-URL: http://www.muru.com/ http://www.atomide.com
X-Accept-Language: fi en
X-Location: USA, California, San Francisco
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen <ak@muc.de> [040802 05:49]:
> Tony Lindgren <tony@atomide.com> writes:
> >
> > Just to clarify a bit, my patch only uses the 800MHz hardcoded, which
> > should work on all AMD64 processors. The max value used is the current
> > running value.
> 
> No, it won't. It will fail on the new/upcomming CPUs with 1Ghz HyperTransport. 
> The minimum frequency cannot be lower than the HyperTransport speed.
> 
> And for others sometimes laptop batteries are not designed to support
> more than 800Mhz.

OK, that's good to know.

> Overall hardcoding such tables is imho a bad idea, unless you
> *really* know what you're doing.

Yes, sounds like it's not needed any longer. The ACPI tables seem to
work fine.

Tony
