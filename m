Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289277AbSBDXaI>; Mon, 4 Feb 2002 18:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289278AbSBDX35>; Mon, 4 Feb 2002 18:29:57 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:3726 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S289277AbSBDX3q>; Mon, 4 Feb 2002 18:29:46 -0500
Date: Mon, 4 Feb 2002 17:29:42 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Willy Tarreau <wtarreau@free.fr>
Cc: jon-anderson@rogers.com, linux-kernel@vger.kernel.org
Subject: Re: 760MPX IO/APIC Errors...
Message-ID: <20020204172942.C14297@asooo.flowerfire.com>
In-Reply-To: <200202031027.g13ARMN03118@ns.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200202031027.g13ARMN03118@ns.home.local>; from wtarreau@free.fr on Sun, Feb 03, 2002 at 11:27:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At what point do your machines stop booting, i.e., what was the last
printed kernel message on the console?  Also, can you send me full
dmesgs from your machines after booting?

I'm trying to corelate these issues with APIC issues I've had in the
past (and I'm thinking of getting the A7M266D at some point).

Thanks,
-- 
Ken.
brownfld@irridia.com

PS: MPS1.4 ==> APIC_DM_FIXED?

On Sun, Feb 03, 2002 at 11:27:22AM +0100, Willy Tarreau wrote:
| Hi Jon,
| 
| same motherboard here, but with 2 XP1800+.
| It couldn't boot until I either disabled IO/APIC or disable MPS1.4 support
| in the bios setup. Finally, I disabled MPS1.4 and let IO/APIC enabled and
| it works really well in SMP. (In fact, I couldn't really imagine how fast
| this could be !)
| 
| Regards,
| Willy
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
