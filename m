Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbTIEKOj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 06:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbTIEKOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 06:14:38 -0400
Received: from b0jm34bky18he.bc.hsia.telus.net ([64.180.152.77]:50693 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S261269AbTIEKOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 06:14:38 -0400
Date: Fri, 5 Sep 2003 03:14:03 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: Re: cpu not being found by 2.6.0-test4, input event bug too
Message-ID: <20030905101403.GA1026@net-ronin.org>
References: <20030905032100.GA32489@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905032100.GA32489@net-ronin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried reverting the one change I made, which was to the BIOS to
disable power management.  Poof.  2nd CPU shows up when I reboot.

The dmesg flood is still going on, though.

Also, the motherboard is an Intel DK440LX (not a 440DX-based chipset).

Any other infor people need, or suggestions on what to look for to track
down the reason SMP won't work unless power management is enabled?

I'm assuming that means APM, considering when the motherboard was made...

-- DN
Daniel
