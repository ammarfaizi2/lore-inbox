Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285471AbRLGUXI>; Fri, 7 Dec 2001 15:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285505AbRLGUW6>; Fri, 7 Dec 2001 15:22:58 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:12692 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S285471AbRLGUWq>; Fri, 7 Dec 2001 15:22:46 -0500
Date: Fri, 7 Dec 2001 12:22:35 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: <arjan@fenrus.demon.nl>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Maximizing brk() space on stock ia32 Linux 2.4.x
In-Reply-To: <m16CRP4-000OWoC@amadeus.home.nl>
Message-ID: <Pine.LNX.4.33.0112071219130.516-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001 arjan@fenrus.demon.nl wrote:

> In article <Pine.LNX.4.33.0112071128500.440-100000@mf1.private> you wrote:
>
> > Given the limitation of running under a stock ia32 Linux 2.4.x kernel
> > (e.g. TASK_UNMAPPED_BASE = 0x40000000 and __PAGE_OFFSET = 0xC0000000), how
> > can one write a program in a way to maximize the address space available
> > for brk()?  For example:
> 
> Try using the "hoard" preload library for malloc() 
> Does wonders...

I'm sure it does wonders for malloc(), but I'm talking about programs that
use sbrk()/brk(), for whatever reason.  :-)  I suppose I could try reading
the source and documentation for "hoard" to see what it does.

Thanks, Wayne


