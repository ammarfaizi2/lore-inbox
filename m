Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129144AbRBJAC7>; Fri, 9 Feb 2001 19:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbRBJACt>; Fri, 9 Feb 2001 19:02:49 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:65531 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S129144AbRBJACn>; Fri, 9 Feb 2001 19:02:43 -0500
Date: Fri, 9 Feb 2001 16:02:34 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Matthew Gabeler-Lee <msg2@po.cwru.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: bttv problems in 2.4.0/2.4.1
In-Reply-To: <Pine.LNX.4.32.0101301830330.1138-100000@cheetah.STUDENT.cwru.edu>
Message-ID: <Pine.LNX.4.21.0102091600320.26669-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have framebuffer console compiled into your kernel? I noticed
similar behavior on my system when I had framebuffer console compiled in,
ACPI or APM (cant remember which, probably ACPI) compiled in, and bttv as
modules. System would power off when ACPI was loaded. Other times it would
do other stupid things like hang abruptly for no apparent reason.

On Tue, 30 Jan 2001, Matthew Gabeler-Lee wrote:

> In 2.4.0 and 2.4.1, when I try to load the bttv driver, one of two
> things happens: the system hangs (even alt-sysrq doesn't work!), or the
> system powers off by itself (ATX mobo).  Instant power-off usually
> happens after a soft reboot (init 6), while it usually hangs up after a
> hard reboot (power cycling).
> 
> When it hangs, I noticed a very strange thing.  If I push the power
> on/off button briefly, it un-hangs and seems to proceed as normal.  The
> kernel does report an APIC error on each cpu (dual p3 700 system) when
> this happens.
> 
> These errors all occur in the same way (as near as I can tell) in
> kernels 2.4.0 and 2.4.1, using bttv drivers 0.7.50 (incl. w/ kernel),
> 0.7.53, and 0.7.55.
> 
> I am currently using 2.4.0-test10 with bttv 0.7.47, which works fine.
> 
> I have sent all this info to Gerd Knorr but, as far as I know, he hasn't
> been able to track down the bug yet.  I thought that by posting here,
> more eyes might at least make more reports of similar situations that
> might help track down the problem.
> 
> PS: I'm not on the linux-kernel list, so please CC replies to me.
> 
> 

-- 
 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
