Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265320AbUBPCMJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 21:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265326AbUBPCMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 21:12:09 -0500
Received: from atari.saturn5.com ([209.237.231.200]:42963 "HELO
	atari.saturn5.com") by vger.kernel.org with SMTP id S265320AbUBPCMD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 21:12:03 -0500
Date: Sun, 15 Feb 2004 18:12:01 -0800
From: Steve Simitzis <steve@saturn5.com>
To: Elikster <elik@webspires.com>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: e1000 problems in 2.6.x
Message-ID: <20040216021201.GA23254@saturn5.com>
References: <20040215152057.GA582@xeon2.local.here> <121605967.20040215181417@webspires.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <121605967.20040215181417@webspires.com>
User-Agent: Mutt/1.3.28i
X-gestalt: heart, barbed wire
X-Cat: calico
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

that doesn't explain it for me. i have NAPI enabled in the kernel, and
i still have problems in 2.6.x, and not in 2.4.22.

CONFIG_E1000=m
CONFIG_E1000_NAPI=y

:(

On 02/15/04, Elikster <elik@webspires.com> wrote: 

> Hello Klaus,
> 
>    Hmmm..that might explains it, since I don't use NAPI enabled on the E1000 and it works fine without in the 2.4.x series kernels, but under 2.6, it barfs half the time.
> 
> Sunday, February 15, 2004, 8:20:57 AM, you wrote:
> 
> KD> I have a Tyan-S2665 mobo which has an intergrated
> KD> e1000 and I never saw such errors with 2.6 kernels. 
> 
> KD> I use it with 100-MBit Full-Duplex in a switched 
> KD> private network.
> 
> KD> CONFIG_IP_MULTICAST=y
> KD> CONFIG_E1000=y
> KD> CONFIG_E1000_NAPI=y
> 
> 
> 
> 
> -- 
> Best regards,
>  Elikster                            mailto:elik@webspires.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

steve simitzis : /sim' - i - jees/
          pala : saturn5 productions
 www.steve.org : 415.282.9979
  hath the daemon spawn no fire?

