Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWBBWcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWBBWcu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWBBWcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:32:50 -0500
Received: from zcars04f.nortel.com ([47.129.242.57]:57282 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP id S932368AbWBBWct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:32:49 -0500
Message-ID: <43E2885E.3070506@nortel.com>
Date: Thu, 02 Feb 2006 16:31:58 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Michael Loftis <mloftis@wgops.com>, David Weinehall <tao@acc.umu.se>,
       Doug McNaught <doug@mcnaught.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
       dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
References: <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com> <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com> <200601201903.k0KJ3qI7006425@turing-police.cc.vt.edu> <E27F809F04C1C673D283E84F@d216-220-25-20.dynip.modwest.com> <20060120200051.GA12610@flint.arm.linux.org.uk> <5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com> <87slrio9wd.fsf@asmodeus.mcnaught.org> <25D702FB62516982999D7084@d216-220-25-20.dynip.modwest.com> <20060202121653.GI20484@vasa.acc.umu.se> <67A0AFFBC77C32B9DEE25EFA@dhcp-2-206.wgops.com> <20060202220158.GA11380@w.ods.org>
In-Reply-To: <20060202220158.GA11380@w.ods.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Feb 2006 22:32:03.0277 (UTC) FILETIME=[7D5EF7D0:01C62848]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:

> Given the past
> experience of 2.4 and the time I can spend on kernel work, I would
> not even consider basing anything on 2.6 before something like 2.6.20-25,
> when it will hopefully settle down a bit.

Unfortunately there are many times when this simply isn't an option. 
I'm currently working on boards that simply are not supported on 2.4. 
Thus either we need to track 2.6, or else we need to pay someone to do 
it for us and hope they do a good job.

Of course what actually happens is that you pick a kernel version 
(hopefully you pick well) and then backport fixes.  Upgrading 
continuously simply isn't an option, as we have multiple vendors 
providing BSPs, drivers, patches, etc. and they're all supported only 
for that specific kernel version.  We can really only upversion the 
kernel once a year or so, if that often.

Chris
