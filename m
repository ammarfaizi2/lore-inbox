Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVCMTH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVCMTH6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 14:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVCMTH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 14:07:57 -0500
Received: from zork.zork.net ([64.81.246.102]:41433 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261423AbVCMTHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 14:07:55 -0500
From: Sean Neakums <sneakums@zork.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-mm3: machine check on sleep, PowerBook5.4
References: <20050312034222.12a264c4.akpm@osdl.org>
	<6upsy37o0v.fsf@zork.zork.net> <1110717016.5787.143.camel@gaston>
	<1110717351.5787.146.camel@gaston> <6uzmx75xiv.fsf@zork.zork.net>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew
	Morton <akpm@osdl.org>, Linux Kernel list
	<linux-kernel@vger.kernel.org>
Date: Sun, 13 Mar 2005 19:07:48 +0000
In-Reply-To: <6uzmx75xiv.fsf@zork.zork.net> (Sean Neakums's message of "Sun,
	13 Mar 2005 16:19:20 +0000")
Message-ID: <6usm2z5pq3.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> writes:

> Both patches give me a successful sleep, although I had to alter the
> second to not #if 0 core99_ata100_enable -- there's another call to
> that function in pmac_feature.c's set_initial_features().
>
> I will try to gather some power numbers.

With the first patch, charge dropped by 33 over 52 minutes, 0.64/min.
With the second patch, charge dropped by 65 over 80 minutes, 0.81/min.

-- 
Dag vijandelijk luchtschip de huismeester is dood
