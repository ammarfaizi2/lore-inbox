Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWBBLoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWBBLoc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWBBLob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:44:31 -0500
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:30687 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S1750853AbWBBLoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:44:30 -0500
Date: Thu, 2 Feb 2006 14:44:29 +0300
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Broken sata (VIA) on Asus A8V (kernel 2.6.14+)
Message-ID: <20060202114429.GA3035@tentacle.sectorb.msk.ru>
References: <20060201162800.GA32196@tentacle.sectorb.msk.ru> <43E13F57.40808@gmail.com> <20060201231911.GA5463@tentacle.sectorb.msk.ru> <43E145B8.6090404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <43E145B8.6090404@gmail.com>
X-Organization: Moscow State Univ., Institute of Mechanics
X-Operating-System: Linux 2.6.15.1-64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 08:35:20AM +0900, Tejun Heo wrote:
> 
> Your BMDMA controller is reporting raised interrupt (0x4) and your drive 
> is saying that it's ready for the next command, yet interrupt handler of 
> sata_via hasn't run and thus the timeout.  It looks like some kind of 
> IRQ routing problem to me although I have no idea how the problem 
> doesn't affect the boot process.
> 
> Can you try to boot with boot parameter pci=noacpi?

That did not help.

And yes, irqbalance is running, as Kenneth suggested.

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

