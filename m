Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267840AbUJONfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267840AbUJONfd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267776AbUJONfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:35:16 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:5839 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267808AbUJONeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:34:01 -0400
Subject: Re: __attribute__((unused))
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041014230802.C28649@flint.arm.linux.org.uk>
References: <20041014220243.B28649@flint.arm.linux.org.uk>
	 <1097791496.5788.2034.camel@baythorne.infradead.org>
	 <20041014230802.C28649@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097843465.9862.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 15 Oct 2004 13:31:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-14 at 23:08, Russell King wrote:
> It's the "later compilers" which I'm worried about here - I think they
> defined "unused" to mean "this really really isn't used and you can
> discard it".  Hence my concern with the above.

This was the explanation I got some time ago

-- quote --

So "used" cases that used "unused" could break, though older compilers
in essence used "unused" to mean both "used" and "unused".  Since
"unused" becomes useless for using in "used" cases, we now must be sure
to use "used" when that's the use that's useful.
			-- Roland McGrath


I found it so helpful it became a .sig 8)

