Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbUAXWqa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 17:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUAXWqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 17:46:30 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:56193 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S262848AbUAXWq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 17:46:28 -0500
Date: Sat, 24 Jan 2004 23:46:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Manfred Spraul <manfred@colorfullife.com>,
       linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] [2.4] forcedeth network driver
Message-ID: <20040124224635.GA3448@ucw.cz>
References: <4012BF44.9@colorfullife.com> <4012D3C6.1050805@pobox.com> <20040124220545.GA3246@ucw.cz> <4012F2B7.3080800@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4012F2B7.3080800@gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 11:33:27PM +0100, Carl-Daniel Hailfinger wrote:

> >>>Do you have specs that show that all nForce versions support unaligned 
> >>>buffers? skb_reserve is a performance feature, I don't want to add it 
> >>>yet. Testing that it works is on our TODO list.
> >>
> >>hmmmm, is nForce ever found on non-x86 boxes?  I would think that 
> >>skb_reserve might be -required- for some platforms.
> > 
> > 
> > AMD64 and PPC64 as far as I know. But you may consider the first one
> > still a x86 box.
> 
> Hmmm. I thought only GeForce graphics were available on PPC64 and nForce
> mainboard chipsets (including the onboard nic) were not.
 
Well, my memory may be tricking me (I'm not really sure about this), but
I remember there was supposed to be a PPC64 northbridge with a HT link,
made exactly for the purpose of connecting an nForce southrbridge to it.
But it definitely is not in production yet.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
