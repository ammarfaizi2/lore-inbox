Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271612AbTGQW43 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271609AbTGQW43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:56:29 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:1548 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271604AbTGQW4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:56:22 -0400
Date: Fri, 18 Jul 2003 01:11:15 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@osdl.org>,
       miquels@cistron.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030718011115.A2600@pclin040.win.tue.nl>
References: <20030716184609.GA1913@kroah.com> <20030717014410.A2026@pclin040.win.tue.nl> <20030716164917.2a7a46f4.akpm@osdl.org> <20030717122600.A2302@pclin040.win.tue.nl> <bf5uqb$3ei$1@news.cistron.nl> <20030717131955.D2302@pclin040.win.tue.nl> <20030717145507.3ce5042c.akpm@osdl.org> <20030718002451.A2569@pclin040.win.tue.nl> <20030717224307.GF19891@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030717224307.GF19891@ca-server1.us.oracle.com>; from Joel.Becker@oracle.com on Thu, Jul 17, 2003 at 03:43:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 03:43:08PM -0700, Joel Becker wrote:
> On Fri, Jul 18, 2003 at 12:24:51AM +0200, Andries Brouwer wrote:
> > Premise: some filesystems or archives store 32 bits.
> > Conclusion: we must be able to handle that.
> > This is unrelated to the kernel, unrelated to system calls,
> > it is related to <sys/sysmacros.h>.
> 
> 	How does linux handle that today?  IIRC, it ignores the high
> 16bits and treats that 32bit number as 8:8.  That is what happens today,
> for every filesystem, whether it stores 32 or 16 bits.
> 	Why expand that?  We can continue to treat 32bit numbers (eg,
> from NFSv2) as 16bit numbers.

:-) A surprising question.
Why expand that?
Because we would like to use more than 16 bits in device numbers.

