Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbRBUW2S>; Wed, 21 Feb 2001 17:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130170AbRBUW2I>; Wed, 21 Feb 2001 17:28:08 -0500
Received: from [63.95.87.168] ([63.95.87.168]:57868 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S129842AbRBUW1H>;
	Wed, 21 Feb 2001 17:27:07 -0500
Date: Wed, 21 Feb 2001 17:27:06 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Nye Liu <nyet@curtis.curtisfong.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Very high bandwith packet based interface and performance problems
Message-ID: <20010221172705.C5113@xi.linuxpower.cx>
In-Reply-To: <20010220181955.A1994@hobag.internal.zumanetworks.com> <E14VXub-0001vv-00@the-village.bc.nu> <20010221140055.A8113@curtis.curtisfong.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <20010221140055.A8113@curtis.curtisfong.org>; from nyet@curtis.curtisfong.org on Wed, Feb 21, 2001 at 02:00:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2001 at 02:00:55PM -0800, Nye Liu wrote:
[snip]
> This is NOT what I'm seeing at all.. the kernel load appears to be
> pegged at 100% (or very close to it), the user space app is getting
> enough cpu time to read out about 10-20Mbit, and FURTHERMORE the kernel
> appears to be ACKING ALL the traffic, which I don't understand at all
> (e.g. the transmitter is simply blasting 300MBit of tcp unrestricted)
> 
> With udp, we can get the full 300MBit throughput, but only if we shape
> the load to 300Mbit. If we increase the load past 300 MBit, the received
> frames (at the user space udp app) drops to 10-20MBit, again due to
> user-space application scheduling problems.

Perhaps excess context switches are thrashing the system?
