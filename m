Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293469AbSCKCIf>; Sun, 10 Mar 2002 21:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293466AbSCKCI0>; Sun, 10 Mar 2002 21:08:26 -0500
Received: from arsenal.visi.net ([206.246.194.60]:233 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S293468AbSCKCIN>;
	Sun, 10 Mar 2002 21:08:13 -0500
X-Virus-Scanner: McAfee Virus Engine
Date: Sun, 10 Mar 2002 21:04:53 -0500
From: Ben Collins <bcollins@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: rgooch@ras.ucalgary.ca, laforge@gnumonks.org, skraw@ithnet.com,
        joe@tmsusa.com, linux-kernel@vger.kernel.org, elsner@zrz.TU-Berlin.DE
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
Message-ID: <20020311020452.GB528@blimpo.internal.net>
In-Reply-To: <20020310163339.H16784@sunbeam.de.gnumonks.org> <20020310.164113.01028736.davem@redhat.com> <200203110055.g2B0tiP24585@vindaloo.ras.ucalgary.ca> <20020310.170338.83978717.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020310.170338.83978717.davem@redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2002 at 05:03:38PM -0800, David S. Miller wrote:
>    From: Richard Gooch <rgooch@ras.ucalgary.ca>
>    Date: Sun, 10 Mar 2002 17:55:44 -0700
> 
>    David S. Miller writes:
>    > The hardware is not capable of doing it, due to bugs in the hw
>    > checksum implementation of the sk98 chipset.  They aren't being
>    > "slow" they just can't possibly implement it for you.
>    
>    So what is currently the best combination of gige card/driver/cost?
>    What do you recommend to the budget-conscious?
> 
> I can only tell you what I know performance wise about cards,
> and currently it looks like:
> 
> 1) Intel E1000
> 2) Tigon2, aka. Acenic
> 3) SysKonnect sk98, but has broken TX checksums.  If it had
>    working TX checksums it would be in 2nd place instead of Acenic.
>    This hw bug is essentially why Acenics were used for all the
>    TUX benchmarks runs instead of SysKonnect cards.
> 4) Tigon3, aka. bcm57xx

How does SysKonnect 9Dxx compare? The driver's not in the kernel tree,
but it is available on their website. Cards seem fairly priced (I have
two, but didn't buy them, and haven't run any tests across them).

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/       Ben Collins    --    Debian GNU/Linux    --    WatchGuard.com      \
`          bcollins@debian.org   --   Ben.Collins@watchguard.com           '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
