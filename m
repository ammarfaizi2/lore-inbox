Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbUDIWip (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 18:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUDIWip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 18:38:45 -0400
Received: from mail1.kontent.de ([81.88.34.36]:45210 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261684AbUDIWio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 18:38:44 -0400
Date: Sat, 10 Apr 2004 00:38:43 +0200
From: Sascha Wilde <wilde@sha-bang.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.x] reboot fails on AMD Athlon System
Message-ID: <20040409223843.GA563@kenny.sha-bang.local>
References: <20040404203254.GA2780@kenny.sha-bang.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040404203254.GA2780@kenny.sha-bang.local>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2004 at 10:32:54PM +0200, Sascha Wilde wrote:
> The conclusion so far: the code that hangs is not changed in
> comparison with Linux 2.4.24 which works for me, so the reason for the
> failure must be elsewhere in the setup of the hardware environment.
> Maybe in the apic disabling code, though it looks very similar to the
> 2.4.24 version, too.  Or in the setup of the AMD [Irongate/Viper]
> chip-set?

I just build a kernel with everything special disabeled:  no APIC
support, no Athlon specific code (set i386), no AMD specific chipset
code (neither IDE/DMA nor AGP/DRI), no PM, no nothing... 

...and it still refuses to reboot -- so the code change which
prevents my system from rebooting must be anywhere in some quite
generic code.  But where could this be?

Any tips, hints or comments would still be highly appreciated!

Please cc me in any reply, I'm not subscribed to the lkml.

cheers 
sascha
-- 
Sascha Wilde : The sum of intelligence on earth is a constant; 
             : population is growing
