Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268145AbRG0P32>; Fri, 27 Jul 2001 11:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268690AbRG0P3S>; Fri, 27 Jul 2001 11:29:18 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:21802
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S268145AbRG0P3M>; Fri, 27 Jul 2001 11:29:12 -0400
Date: Fri, 27 Jul 2001 08:29:18 -0700
From: Larry McVoy <lm@bitmover.com>
To: Samuel Dupas <samuel@dupas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel paging request at virtual address 3b617b05 ( was Re: swap_free: swap-space map bad (entry 00000100) )
Message-ID: <20010727082918.A27780@work.bitmover.com>
Mail-Followup-To: Samuel Dupas <samuel@dupas.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010727111313.1da63aca.samuel@dupas.com> <20010727162423.2fb6fc80.samuel@dupas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010727162423.2fb6fc80.samuel@dupas.com>; from samuel@dupas.com on Fri, Jul 27, 2001 at 04:24:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 04:24:23PM +0100, Samuel Dupas wrote:
> I change the kernel (now 2.2.19) and I still have the same problem. It
> begin by a "Unable to handle kernel paging request at virtual address"

Did you change memory or CPU lately?  I had a pile of these yesterday 
after we dropped in a 1.3Ghz K7.  Turned out our memory was border line,
I swapped in some new mem and no more problems.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
