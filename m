Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268444AbTCCInU>; Mon, 3 Mar 2003 03:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268445AbTCCInU>; Mon, 3 Mar 2003 03:43:20 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:463
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268444AbTCCInT>; Mon, 3 Mar 2003 03:43:19 -0500
Date: Mon, 3 Mar 2003 03:51:46 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: ChristopherHuhn <c.huhn@gsi.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Bug at spinlock.h ?!
In-Reply-To: <3E630E3D.8060405@GSI.de>
Message-ID: <Pine.LNX.4.50.0303030348130.25240-100000@montezuma.mastecende.com>
References: <3E630E3D.8060405@GSI.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, ChristopherHuhn wrote:

> Hi folks,
> 
> we have some problems with the 2.4.20 kernel on our linux farm, mainly - but 
> not exclusivly - on our batch processing 2x2GHz Xeon (with hyperthreading), 
> Intel e7500 supermicro P4-DPE boxes running - almost plain - Debian woody.
> 
> On these boxes (ca. 60) we sometimes get a kernel panic after an uptime of 2 
> days or more. The process causing the panic is sometimes a users number 
> crunching process but more often ksoftirqd_CPU0 or swapper.
> 
> Today we got this profound error msg:
> Kernel Bug at /usr/src/kernel-source-2.4.20/include/asm/spinlock.h:105!

Sounds like possible memory corruption (can you vouch for the reliability 
of your RAM?) Might be worthwhile posting the oops in it's entirety. Is 
EIP normally in __run_timers? Do you run a heavy networking load?

	Zwane
-- 
function.linuxpower.ca
