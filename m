Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130287AbRALJyx>; Fri, 12 Jan 2001 04:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130539AbRALJyo>; Fri, 12 Jan 2001 04:54:44 -0500
Received: from mail1.rdc2.ab.home.com ([24.64.2.48]:7616 "EHLO
	mail1.rdc2.ab.home.com") by vger.kernel.org with ESMTP
	id <S130287AbRALJyY>; Fri, 12 Jan 2001 04:54:24 -0500
Date: Fri, 12 Jan 2001 02:47:42 -0700
From: "Harold Oga" <ogah@home.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
Message-ID: <20010112024742.A5703@ogah.cgma1.ab.wave.home.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
	Andi Kleen <ak@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010111184645.B828@athlon.random> <Pine.LNX.4.10.10101111803580.18517-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101111803580.18517-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jan 11, 2001 at 06:08:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 06:08:21PM -0800, Linus Torvalds wrote:
>
>Could people with Athlons please verify that pre3 works for them?
>
>It's basically Andrea's patch, but I moved the FPU save/restore games away
>from arch/i386/lib/mmx.c, so that everything is properly done in one place
>and others call the appropriate helper functions instead of thinking that
>they know how the lazy FP switching is done.
Hi Linus,
   Ok, 2.4.1-pre3 seems to work fine for me on my Thunderbird 900MHz system.
At least, XFree86 4.0.1 starts properly, and the output of ps aux looks
correct again, which wasn't the case with 2.4.1-pre1 (I never tried
2.4.1-pre2).

-Harold
-- 
"Life sucks, deal with it!"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
