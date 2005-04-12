Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVDLWeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVDLWeE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVDLWbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:31:21 -0400
Received: from waste.org ([216.27.176.166]:33922 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262531AbVDLW2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:28:32 -0400
Date: Tue, 12 Apr 2005 15:28:10 -0700
From: Matt Mackall <mpm@selenic.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       Ihalainen Nickolay <ihanic@dev.ehouse.ru>, admin@list.net.ru,
       linux-kernel@vger.kernel.org, Wen Xiong <wendyx@us.ibm.com>
Subject: Re: Digi Neo 8: linux-2.6.12_r2  jsm driver
Message-ID: <20050412222810.GA3174@waste.org>
References: <335DD0B75189FB428E5C32680089FB9F122164@mtk-sms-mail01.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335DD0B75189FB428E5C32680089FB9F122164@mtk-sms-mail01.digi.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 04:46:10PM -0500, Kilau, Scott wrote:
> Hi Matt,
> 
> The ball is in my court, because my wishes as a copyright holder are not
> being honored.
>
> Which is the right of Christoph because of the GPL, but it sure doesn't
> help the end
> users of said product.
> Your claim that you are trying to "help" end users is bogus and just
> plain wrong.

Your end users do not benefit from drivers that are not well
integrated with the kernel. If a user has to jump through hoops to
make their hardware work (including downloading extra drivers, etc.),
that is not a benefit. Case in point: the patch in question _came from
an end user_.

We've now got 12 years experience in the headaches of out of tree
drivers (binary or not) as users, developers, and distributors, and
we're sick of it. We're not supporting that approach any more, they
don't exist as far as we're concerned until they're candidates for
merger. Your hardware is no exception.

> > As such, we make very little allowance
> > for their concerns, especially when they stand in
> > the way of improving things that _are_ in the kernel.
> 
> How is shipping a stripped down version of the driver, by yanking things
> our customers want, improving the "things that are in the kernel"?

End users do not benefit from bad interfaces. This may seem in
conflict with the above, but it's not. One of the main benefits of
kernel integration is that the trouble spots get sorted out and the
interfaces get cleaned up. This is good for everyone. Feel free to
resubmit those features when they're done right.

This is what your customers want, whether they know it yet or not.
Anything else is a stopgap.

> When the user installs my driver with all the extra features that our
> customers
> really want, I will simply check to see if jsm.ko exists, and ask the
> user if I
> can blow away the jsm.ko module.

And the rest of us make a note to not get Digi hardware because we're
sick of these out of tree drivers and the unspeakable hacks they
generally contain in the name of special features.

-- 
Mathematics is the supreme nostalgia of our time.
