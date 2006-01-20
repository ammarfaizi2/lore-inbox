Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWATUZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWATUZq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWATUZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:25:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14865 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932166AbWATUZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:25:46 -0500
Date: Fri, 20 Jan 2006 20:25:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michael Loftis <mloftis@wgops.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060120202534.GB12610@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Loftis <mloftis@wgops.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Marc Koschewski <marc@osknowledge.org>,
	linux-kernel@vger.kernel.org
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> <20060120155919.GA5873@stiffy.osknowledge.org> <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com> <Pine.LNX.4.61.0601201738570.10065@yvahk01.tjqt.qr> <5F952B75937998C1721ACBA8@d216-220-25-20.dynip.modwest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F952B75937998C1721ACBA8@d216-220-25-20.dynip.modwest.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 10:14:15AM -0700, Michael Loftis wrote:
> It's easier for an embedded system especially to pick a target, and then 
> stay with it.  Later when a new major version comes out the time can then 
> be invested ONCE to redevelop what needs redeveloping, which is easier to 
> do (yes I'm speaking from a business standpoint, sorry, but someone has to) 
> and to sell to management than nickel-and-dime to death of trying to follow 
> a development tree.

Please note that the current development strategy suits embedded folk.

With the old model, embedded folk could not wait two years for a (eg)
2.5 kernel to become a 2.6 kernel and then "stabilise".  In two years,
the new SoC is already in full-use in multiple applications and folk
have been and long gone developing their products.

So what happens is a massive conflict of interest - do we put
$mass-of-new-features into 2.4 kernels at the risk of destabilising
the current users, or do we push it into 2.5 and wait two or more
years before folk start using that code.

Like it or not, the latter causes a _lot_ of difficulties for a _lot_
of people, so much so that it's an economic disaster unless you're a
large corporation.  The former is also a non-starter because then you
end up with folk complaining that it should be in the development
branch.  It's a no-win situation - you can't satisfy everyone.

So, our current model is a compromise - you get _told_ that things
will change well in advance, and if you choose to ignore those warnings
(or don't respond to them) that's entirely your own problem.

It's like a stick and carrot scenario - see
http://everything2.com/index.pl?node=stick%20and%20carrot

The carrot in this case is the notice about devfs removal.  The
stick is the actual devfs removal.  One's pleasant, the other isn't.
Which you take notice of is entirely your choice.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
