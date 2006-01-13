Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423026AbWAMWXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423026AbWAMWXL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423024AbWAMWXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:23:11 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:6417 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1423021AbWAMWXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:23:09 -0500
Date: Fri, 13 Jan 2006 17:22:59 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: wireless: recap of current issues (stack)
Message-ID: <20060113222259.GL16166@tuxdriver.com>
Mail-Followup-To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213200.GG16166@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113213200.GG16166@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stack
=====

Is the in-kernel stack up-to-date w/ SourceForge?  No.  Why not?
Can this development be brought into wireless development kernels?

Can the in-kernel stack be saved?  With the addition of softmac?
Is it possible to extend softmac to support virtual wlan devices?
If not, how do we proceed?

How do we get more drivers in-kernel?  (Multiple stacks probably
don't help beyond the short-term timeframe.)

I think we need to rally as many driver writers as possible a) to
get into the kernel now; and, b) move away from duplicating stack
features.  I don't see how to achieve that with the DeviceScape stack
in the short- or medium-term timeframe.  I get the impression that
porting drivers from one stack to the other is not all that painful,
particularly in the ieee80211->DeviceScape direction.  Is it reasonable
to expect short-term development to stay with the ieee80211 stack,
while planning either a migration to DeviceScape or a major ieee80211
overhaul based on the DeviceScape code?

Do we need to have both wireless-stable and wireless-devel kernels?
What about the suggestion of having both stacks in the kernel at once?
I'm not very excited about two in-kernel stacks.  Still, consolidating
wireless drivers down to two stacks is probably better than what we
have now...?  Either way, we would have to have general understanding
that at some point (not too far away), one of the stacks would have
to disappear.
-- 
John W. Linville
linville@tuxdriver.com
