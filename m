Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130073AbQK3TYN>; Thu, 30 Nov 2000 14:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130820AbQK3TYC>; Thu, 30 Nov 2000 14:24:02 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:56058
        "EHLO opus.bloom.county") by vger.kernel.org with ESMTP
        id <S130073AbQK3S7Q>; Thu, 30 Nov 2000 13:59:16 -0500
Date: Thu, 30 Nov 2000 11:26:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre24
Message-ID: <20001130112643.A16256@opus.bloom.county>
In-Reply-To: <E140wh7-0005Na-00@the-village.bc.nu> <20001129150159.Y872@opus.bloom.county> <20001130181740.A18566@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001130181740.A18566@athlon.random>; from andrea@suse.de on Thu, Nov 30, 2000 at 06:17:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 06:17:40PM +0100, Andrea Arcangeli wrote:
> On Wed, Nov 29, 2000 at 03:01:59PM -0700, Tom Rini wrote:
> > As Dave Miller pointed out, DEV_MAC_HID sysctl conflicts with the RAID patches
> 
> That's right but OTOH I'd simply declare the sysctl-by-number interface dead
> for new introduced sysctl. We need to preserve backwards compatibility of
> course but that's not a problem. I'd preferred if we killed it completly (just
> providing backwards compatibility) during the 2.4.x cycle. Only reliable
> way to use new sysctl is sysctl-by-name IMHO.

Right.  But the problem here was a new, unused sysctl-by-number, conflicted
with an old-but-not-integrated sysctl-by-number that is used. :)  The only
reason I made the number match the one in 2.4 was because a) i figured it's
not going to conflict. :) and b) incase something does come along and use it.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
