Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131780AbQKKSai>; Sat, 11 Nov 2000 13:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131828AbQKKSa3>; Sat, 11 Nov 2000 13:30:29 -0500
Received: from Cantor.suse.de ([194.112.123.193]:60177 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131780AbQKKSaP>;
	Sat, 11 Nov 2000 13:30:15 -0500
Date: Sat, 11 Nov 2000 19:30:12 +0100
From: Andi Kleen <ak@suse.de>
To: Robert Lynch <rmlynch@best.com>
Cc: linux-kernel@vger.kernel.org, Peter Samuelson <peter@cadcamlab.org>,
        Andi Kleen <ak@suse.de>
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001111193012.A30963@gruyere.muc.suse.de>
In-Reply-To: <3A0C86B3.62DA04A2@best.com> <20001110234750.B28057@wire.cadcamlab.org> <20001111153036.A28928@gruyere.muc.suse.de> <3A0D89F7.1CDC3B68@best.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A0D89F7.1CDC3B68@best.com>; from rmlynch@best.com on Sat, Nov 11, 2000 at 10:03:35AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 10:03:35AM -0800, Robert Lynch wrote:
> sys_nfsservctl                      80     1060     980  +1225.0
> dump_extended_fpu                    8       84      76  +950.00
> get_fpregs                          36      372     336  +933.33
> schedule_tail                       16      144     128  +800.00 
> set_fpregs                          36      272     236  +655.56
> tty_release                         16      108      92  +575.00
> ext2_write_inode                    20      108      88  +440.00
> ...
> 
> I have surpressed my momentary urge to post the whole thing, so
> as not to arouse the legendary ire of this list. :)

Ordering by byte delta is more useful than by Change to get the real
pigs, because Change gives high values even for relatively small changes
(like 8 -> 84) 

Also note that some of the output is bogus due to inaccurate nm output
(bloat-o-meter relies on nm) 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
