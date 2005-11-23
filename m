Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbVKWQ1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbVKWQ1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVKWQ1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:27:43 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51984 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750987AbVKWQ1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:27:42 -0500
Date: Wed, 23 Nov 2005 16:27:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Marc Koschewski <marc@osknowledge.org>, Jon Smirl <jonsmirl@gmail.com>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051123162728.GJ15449@flint.arm.linux.org.uk>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	Marc Koschewski <marc@osknowledge.org>,
	Jon Smirl <jonsmirl@gmail.com>, Greg KH <greg@kroah.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk> <9e4733910511230719h67fa96bdxdeb654aa12f18e67@mail.gmail.com> <20051123160231.GC6970@stiffy.osknowledge.org> <20051123161637.GI15449@flint.arm.linux.org.uk> <20051123162337.GA2434@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123162337.GA2434@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 05:23:37PM +0100, Vojtech Pavlik wrote:
> On Wed, Nov 23, 2005 at 04:16:37PM +0000, Russell King wrote:
> > It means that we spun in the serial interrupt for more than 256 times
> > and reached the limit on the amount of work we were prepared to do.
> > Any idea what you were doing when these happened?
>  
> Because ACPI was right and the second serial port isn't there?

Well, it certainly looked like a serial port when it was probed - to the
extent that even loopback mode worked.  Hence I'd be very surprised if
it wasn't there.

It's the same test that's being applied as has been for the last 14
years to detect if a port is present or not.  Maybe Ted T'so would
be aware if it can optimistically discover ports?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
