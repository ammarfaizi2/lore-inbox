Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263641AbUD2HgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbUD2HgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 03:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbUD2HgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 03:36:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8464 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263641AbUD2HgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 03:36:18 -0400
Date: Thu, 29 Apr 2004 08:36:08 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Marc Singer <elf@buici.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429083608.A8169@flint.arm.linux.org.uk>
Mail-Followup-To: Marc Singer <elf@buici.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
	brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40904A84.2030307@yahoo.com.au> <20040429005801.GA21978@buici.com> <40907AF2.2020501@yahoo.com.au> <20040429042047.GB26845@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040429042047.GB26845@buici.com>; from elf@buici.com on Wed, Apr 28, 2004 at 09:20:47PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 09:20:47PM -0700, Marc Singer wrote:
> Russell King is working on a lot of things for the MMU code in ARM.
> I'm waiting to see where he ends up.  I believe he's planning on
> removing the lazy PTE release logic.

Essentially it came to a grinding halt due to the shere size of the
task of sorting out the crappy includes, which is far to large for a
stable kernel.

I may go back to the original problem and sort it a different way,
but for the time being, I'm occupied in other areas.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
