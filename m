Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132101AbQKKS6d>; Sat, 11 Nov 2000 13:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132036AbQKKS6X>; Sat, 11 Nov 2000 13:58:23 -0500
Received: from proxy4.ba.best.com ([206.184.139.15]:25874 "EHLO
	proxy4.ba.best.com") by vger.kernel.org with ESMTP
	id <S131942AbQKKS6K>; Sat, 11 Nov 2000 13:58:10 -0500
Message-ID: <3A0D9690.E55465F4@best.com>
Date: Sat, 11 Nov 2000 10:57:20 -0800
From: Robert Lynch <rmlynch@best.com>
Reply-To: rmlynch@best.com
Organization: Carpe per diem
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Peter Samuelson <peter@cadcamlab.org>
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <3A0C86B3.62DA04A2@best.com> <20001110234750.B28057@wire.cadcamlab.org> <20001111153036.A28928@gruyere.muc.suse.de> <3A0D89F7.1CDC3B68@best.com> <20001111193012.A30963@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Sat, Nov 11, 2000 at 10:03:35AM -0800, Robert Lynch wrote:
> > sys_nfsservctl                      80     1060     980  +1225.0
> > dump_extended_fpu                    8       84      76  +950.00
> > get_fpregs                          36      372     336  +933.33
> > schedule_tail                       16      144     128  +800.00
> > set_fpregs                          36      272     236  +655.56
> > tty_release                         16      108      92  +575.00
> > ext2_write_inode                    20      108      88  +440.00
> > ...
> >
> > I have surpressed my momentary urge to post the whole thing, so
> > as not to arouse the legendary ire of this list. :)
> 
> Ordering by byte delta is more useful than by Change to get the real
> pigs, because Change gives high values even for relatively small changes
> (like 8 -> 84)
> 
> Also note that some of the output is bogus due to inaccurate nm output
> (bloat-o-meter relies on nm)
> 
> -Andi

Yer right, here's a biggie I missed:

stext_lock                        4344    29395   25051  +576.68

Bob L. 
-- 
Robert Lynch-Berkeley CA USA-rmlynch@best.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
