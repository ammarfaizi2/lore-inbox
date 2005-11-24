Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbVKXPPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbVKXPPl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVKXPPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:15:41 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:41274 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751369AbVKXPPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:15:40 -0500
Date: Thu, 24 Nov 2005 10:15:38 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.15-rc2
In-reply-to: <Pine.LNX.4.61.0511240741020.5619@goblin.wat.veritas.com>
To: linux-kernel@vger.kernel.org
Message-id: <200511241015.38616.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511231937.34206.gene.heskett@verizon.net>
 <Pine.LNX.4.61.0511240741020.5619@goblin.wat.veritas.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 November 2005 02:45, Hugh Dickins wrote:
>On Wed, 23 Nov 2005, Gene Heskett wrote:
>> On Wednesday 23 November 2005 18:40, Hugh Dickins wrote:
[snip previouus blowup]
>That's one of the things fixed by Andrew's patch below
>(though Linus fixed it differently in the end).
>Or you could just wait for 2.6.15-rc2-git4, should be along soon.
>
>Hugh

Got it, building src tree now, config'd & building.

And, I unchecked everything but what I need to run this card (I think,
whatdoIknow) and got this at depmod time:
WARNING:
/lib/modules/2.6.15-rc2-git4/kernel/drivers/media/video/cx88/cx88-dvb.ko
needs unknown symbol mt352_attach
WARNING:
/lib/modules/2.6.15-rc2-git4/kernel/drivers/media/video/cx88/cx88-dvb.ko
needs unknown symbol nxt200x_attach
WARNING:
/lib/modules/2.6.15-rc2-git4/kernel/drivers/media/video/cx88/cx88-dvb.ko
needs unknown symbol mt352_write
WARNING:
/lib/modules/2.6.15-rc2-git4/kernel/drivers/media/video/cx88/cx88-dvb.ko
needs unknown symbol lgdt330x_attach
WARNING:
/lib/modules/2.6.15-rc2-git4/kernel/drivers/media/video/cx88/cx88-dvb.ko
needs unknown symbol cx22702_attach

Maybe somebody can take the time to tell me what I do need to run a
pcHDTV-3000 in both ntsc and atsc modes using this newer code?
I was under the impression I needed the cx88 stuffs, ORV51132 (for
atsc) and nxt2002(for ntsc), but now we have lots of other dependencies
out the wazoo.  Please clarify.
-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.


