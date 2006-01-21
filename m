Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWAUADK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWAUADK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWAUADK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:03:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16144 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750816AbWAUADI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:03:08 -0500
Date: Sat, 21 Jan 2006 00:03:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michael Loftis <mloftis@wgops.com>
Cc: Greg KH <greg@kroah.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060121000302.GD20148@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Loftis <mloftis@wgops.com>,
	Greg KH <greg@kroah.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Marc Koschewski <marc@osknowledge.org>,
	linux-kernel@vger.kernel.org
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> <20060120155919.GA5873@stiffy.osknowledge.org> <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com> <Pine.LNX.4.61.0601201738570.10065@yvahk01.tjqt.qr> <5F952B75937998C1721ACBA8@d216-220-25-20.dynip.modwest.com> <20060120194331.GA8704@kroah.com> <1C4B548965AFD4F5918E838D@d216-220-25-20.dynip.modwest.com> <20060120232703.GB20949@kroah.com> <EB336A2509046CFEBF52A9E2@d216-220-25-20.dynip.modwest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB336A2509046CFEBF52A9E2@d216-220-25-20.dynip.modwest.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 04:52:00PM -0700, Michael Loftis wrote:
> --On January 20, 2006 3:27:03 PM -0800 Greg KH <greg@kroah.com> wrote:
> >And before you say, "but they are only for some very odd and not popular
> >devices, no one would want them in the kernel tree!", remember that we
> >have whole arches that are only run by about 2 users.  I know
> >specifically about a few drivers that only work on 1 device in the whole
> >world.  So this isn't a good excuse :)
> 
> OK well, this I hadn't realised, my impression was that the case was mostly 
> or entirely opposite of this.  That a new bit had to have really good buy 
> in before it could get anywhere near any mainline development, much less 
> release cycles.  I'll have to get really snuggly with the whole release 
> policy again, I was under the (now I see very wrong, I'm sorry gents) 
> impression there wasn't this major of a shift going on.  I simply don't 
> have the bandwidth to follow l-k most of the time.

In the case of ARM machine types, it is the opposite of Greg's
statement.  There's getting on for 1000 ARM machine types.  We have
some 72 machine types currently merged and buildable.

If everyone merged their little-used ARM machine type - say we got
to 250 types, the maintainence burden on _me_ personally would be,
to put it mildly, prohibitive.  Rather than fixing up all machine
support code when I made any change, I'd ignore most of them and
just do the ones I was interested in.

That results in most merged code falling into a state where it's
essentially broken, and a _lot_ more folk whinging about change.

Alternatively, as I said in my other recent mail, we could stagnate.

Here's a thought - if this is soo important, would you pay me to
stagnate the ARM part of the kernel tree? 8)  (rmk thinks... could
run this as a "highest bidder gets their way") 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
