Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271060AbTGPUim (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271010AbTGPUil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:38:41 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:4757 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S270993AbTGPUih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:38:37 -0400
Date: Wed, 16 Jul 2003 22:53:19 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dave Jones <davej@codemonkey.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030716205319.GA20760@ucw.cz>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de> <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk> <20030716171607.GM833@suse.de> <20030716172331.GD21896@suse.de> <20030716190018.GE20241@ucw.cz> <20030716193002.GA2900@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716193002.GA2900@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 08:30:02PM +0100, Dave Jones wrote:
> On Wed, Jul 16, 2003 at 09:00:18PM +0200, Vojtech Pavlik wrote:
> 
>  > Dave, can you please enable the DEBUG in i8042.c so that I can see
>  > whether the bytes really get lost or if the unsync check is just
>  > triggering by mistake?
> 
> Intriguing. With DEBUG enabled, I get a few gig of logs, but
> I can't trigger the dancing mouse pointer any more. With it
> disabled, I can reproduce it within a minute or two.
> 
> Seems to be a timing related bug.

Ouch.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
