Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130242AbRBCWK6>; Sat, 3 Feb 2001 17:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130933AbRBCWKs>; Sat, 3 Feb 2001 17:10:48 -0500
Received: from [209.53.19.107] ([209.53.19.107]:22400 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id <S130242AbRBCWKk>;
	Sat, 3 Feb 2001 17:10:40 -0500
Date: Sat, 3 Feb 2001 14:10:39 -0800
From: Shane Wegner <shane@cm.nu>
To: linux-kernel@vger.kernel.org
Subject: Re: SMP problem with 2.2.19pre8
Message-ID: <20010203141039.A3032@cm.nu>
In-Reply-To: <20010203140727.A2873@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010203140727.A2873@cm.nu>; from shane@cm.nu on Sat, Feb 03, 2001 at 02:07:27PM -0800
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2001 at 02:07:27PM -0800, Shane Wegner wrote:
> Hi,
> 
> I just built this SMP system and am getting some weird
> errors from kern.log.  The system will run smoothly but
> after about a half hour running the distributed.net RC5
> client, the following errors show up.
> 
> Feb  3 04:40:18 continuum kernel: stuck on TLB IPI wait
> (CPU#0)
> Feb  3 04:40:23 continuum last message repeated 4 times
> Feb  3 04:40:45 continuum last message repeated 4 times
> Feb  3 04:40:56 continuum kernel: stuck on TLB IPI wait
> (CPU#1)
> Feb  3 04:41:02 continuum last message repeated 2 times

I should also mention that the kernel has the following
patches applied.
00-piii-8
01-ide-2.2.18.1221.patch
02-raid-2.2.18b3


-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
