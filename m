Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFDGn>; Fri, 5 Jan 2001 22:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbRAFDGe>; Fri, 5 Jan 2001 22:06:34 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:40463 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S129406AbRAFDG1>; Fri, 5 Jan 2001 22:06:27 -0500
Date: Fri, 5 Jan 2001 19:06:10 -0800
To: "Michael D. Crawford" <crawford@goingware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to Power off with ACPI/APM?
Message-ID: <20010105190610.B14712@ferret.phonewave.net>
In-Reply-To: <3A560FDA.ABB3EF08@goingware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A560FDA.ABB3EF08@goingware.com>; from crawford@goingware.com on Fri, Jan 05, 2001 at 06:18:02PM +0000
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 06:18:02PM +0000, Michael D. Crawford wrote:
> > Silly question, but have you realized that you don't have to enable 
> > SMP in kernel to do multithreading ? 
> 
> Lest anyone think me completely clueless, yes, I'm well aware of that.  It's
> just that I wanted to have that warm fuzzy feeling the comes from pretending I
> had the cash to buy a dual processor machine when I bought this PC.
> 
> I had planned too, but my laptop died and I needed a new box in a hurry so I had
> to get what I could get.  It's a decent motherboard though, for being single
> processor.
> 
> On the other hand, I did identify that you can't power off with smp enabled
> unless (as someone helpfully posted) you give this parameter in lilo or grub:
> 
> apm=power-off
> 
> While the SMP config option says APM doesn't work if you have SMP enabled (so I
> should have known), it would be helpful to mention that you can still power off
> this way.

It would be even more helpful to make this into a kernel configuration
option dependant on the SMP setting (disable APM configuration, and ask
'Power off machine on shutdown?' instead).
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
