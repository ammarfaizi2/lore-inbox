Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVJ3XRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVJ3XRL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 18:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVJ3XRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 18:17:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43788 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932401AbVJ3XRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 18:17:10 -0500
Date: Sun, 30 Oct 2005 23:17:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, torvalds@osdl.org, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-ID: <20051030231702.GH2846@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, ak@suse.de,
	torvalds@osdl.org, tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
	linux-kernel@vger.kernel.org
References: <12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com> <20051029195115.GD14039@flint.arm.linux.org.uk> <Pine.LNX.4.64.0510291314100.3348@g5.osdl.org> <p73r7a4t0s7.fsf@verdi.suse.de> <20051029223723.GJ14039@flint.arm.linux.org.uk> <20051030111241.74c5b1a6.akpm@osdl.org> <20051030214309.GE2846@flint.arm.linux.org.uk> <20051030143103.17f2835c.akpm@osdl.org> <20051030224524.GG2846@flint.arm.linux.org.uk> <20051030145533.5733b12d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030145533.5733b12d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 02:55:33PM -0800, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> >  That's fine if you have the hardware to be able to debug these issues.
> 
> Most driver bugs cannot be reproduced by the developer.  Almost by
> definition: if the patch had caused problems on the developer's machine, he
> wouldn't have shipped it.
> 
> This is why we have this wonderful group of long-suffering people who
> download and test development kernels for us, and who take the time to
> report defects.
> 
> Yes, it's painful to get into a long-range debugging session, sending debug
> patches, twelve-hour turnaround, etc.  But what alternative have we?

However, it helps if you have a grasp of technologies like ACPI,
IO-APICs, APICs, PCI IRQ routing for x86 problems.  Since I don't
work in the x86 field, I have _zero_ knowledge of such things
because they just don't apply when working on ARM.

That makes debugging x86 problems a nightmare.  Remember I gave
up with trying to sort out peoples PCMCIA problems?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
