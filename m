Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132803AbRBEFVq>; Mon, 5 Feb 2001 00:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132853AbRBEFV1>; Mon, 5 Feb 2001 00:21:27 -0500
Received: from [63.95.87.168] ([63.95.87.168]:46093 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S132803AbRBEFVU>;
	Mon, 5 Feb 2001 00:21:20 -0500
Date: Mon, 5 Feb 2001 00:21:19 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Brian Wolfe <ahzz@terrabox.com>
Cc: Hans Reiser <reiser@namesys.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
Message-ID: <20010205002119.A31043@xi.linuxpower.cx>
In-Reply-To: <E14OoD8-0007GI-00@the-village.bc.nu> <3A7B2F7C.52AA6AFA@namesys.com> <20010204205013.D23921@ironsides.terrabox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <20010204205013.D23921@ironsides.terrabox.com>; from ahzz@terrabox.com on Sun, Feb 04, 2001 at 08:50:13PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 04, 2001 at 08:50:13PM -0600, Brian Wolfe wrote:
[snip]
> 	From the debate raging here is what I gathered is acceptable....
> 
> make it blow up fataly and immediatly if it detects Red Hat + gcc 2.96-red_hat_broken(forgot version num)
> make it provide a URL to get the patch to remove this safeguard if you really want this.
> 
> 	The fatal crash should be VERY carefull to only trigger on a redhat system with the broken compiler. And to satisfy your agument that people may need to be able to use it, provide a reverse patch to remove this safeguard in one easy cat file | patch.

No. There are *many* other compilers out there which are much *more* broken
then anything RedHat has recently shipped. Unfortunatly, there is no easy
way to accuratly test for such bugs (because once they can be boiled down to
a simple test they are very rapidly fixed, what's left is voodoo).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
