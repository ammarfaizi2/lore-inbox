Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271421AbRIVOkB>; Sat, 22 Sep 2001 10:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271333AbRIVOjv>; Sat, 22 Sep 2001 10:39:51 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:59914 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S271329AbRIVOjc>; Sat, 22 Sep 2001 10:39:32 -0400
Date: Sat, 22 Sep 2001 15:39:50 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: spurious interrupt with ac kernel but not with vanilla 2.4.9
Message-ID: <20010922153950.A48207@compsoc.man.ac.uk>
In-Reply-To: <Pine.LNX.4.33.0109211905530.31425-100000@Expansa.sns.it> <E15kU6U-0000cK-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15kU6U-0000cK-00@the-village.bc.nu>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 06:28:42PM +0100, Alan Cox wrote:

> > yes, i was using a non SMP kernel with both apic and io_apic support
> > enabled.
> 
> Ok.
> Oh your configuration options should have worked. Its more a case of working
> out now why the didnt. Knowing that it is uniprocessor apic triggered is a
> help there

I have been getting these spurious interrupt messages for a long time now with
the UP_APIC option enabled. Using interrupt-heavy things like catting logs on a vesafb
console are a pretty reliable way to trigger it.

This is on a bog-standard UP box with no IO-APIC.

It doesn't seem to affect stability at all.

regards
john

p.s. what's going on with the config options ? linus pre12 seems to get rid of the
APIC fake zero page thing and enable the local APIC on UP properly, but the config options
don't seem to have changed like in the ac tree

-- 
"If you're not part of the problem, you're part of the problem space." 
