Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUFBSBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUFBSBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263776AbUFBSBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:01:09 -0400
Received: from zero.aec.at ([193.170.194.10]:14855 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263784AbUFBSAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 14:00:38 -0400
To: Arthur Perry <kernel@linuxfarms.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: GART Error 11
References: <22qyw-6e7-29@gated-at.bofh.it> <22ELe-oP-47@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 02 Jun 2004 20:00:34 +0200
In-Reply-To: <22ELe-oP-47@gated-at.bofh.it> (Arthur Perry's message of "Wed,
 02 Jun 2004 16:20:16 +0200")
Message-ID: <m3vfi96drx.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arthur Perry <kernel@linuxfarms.com> writes:

> Hello,
>
> Oops. Sorry I have made a mistake in all of my statements below.
> It was after 5pm yesterday, and it was a long day...
> It's not offset 0x44 that we are interested in.
> My listings were at offset 0x48, which is MCA NB Status Low Register.
> Sorry, did not mean to confuse anybody.

I would recommend to just read the MC* MSRs via /dev/msr.
Accessing the northbridge directly for MCE information has various
quirks and i removed that completely in the 2.6 driver.
They contain the same information.

-Andi

