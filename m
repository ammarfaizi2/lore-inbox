Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRBGVBY>; Wed, 7 Feb 2001 16:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129608AbRBGVBP>; Wed, 7 Feb 2001 16:01:15 -0500
Received: from p3EE3CB81.dip.t-dialin.net ([62.227.203.129]:11781 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129084AbRBGVBJ>; Wed, 7 Feb 2001 16:01:09 -0500
Date: Wed, 7 Feb 2001 21:29:23 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: VIA silent disk corruption - likely fix
Message-ID: <20010207212923.F7646@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010205150802.A1568@colonel-panic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010205150802.A1568@colonel-panic.com>; from pdh@colonel-panic.com on Mon, Feb 05, 2001 at 15:08:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Feb 2001, Peter Horton wrote:

> I've found the cause of silent disk corruption on my A7V motherboard,
> and it might affect all boards with the same North bridge (KT133 etc).

...

> [1] the BIOS appears to let you change the option but it defaults the
> option the moment you leave the "advanced settings" screen :-(

Is your BIOS current? Gigabyte 7ZXR BIOSes (F4) e. g. have exhibited
not-so-different troubles (once you set a suspend timeout, you could not
reset it lest you reloaded the entire BIOS anew; with American
Megatrends' BIOS this means you lose ALL settings except your Standard
CMOS setup), this problem is fixed in F5J (I did not bother to look for
an official F5 release yet).

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
