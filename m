Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVFSPpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVFSPpc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 11:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVFSPpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 11:45:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40970 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261954AbVFSPp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 11:45:28 -0400
Date: Sun, 19 Jun 2005 16:45:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ISA DMA controller hangs
Message-ID: <20050619164521.A13005@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <42987450.9000601@drzeus.cx> <1117288285.2685.10.camel@localhost.localdomain> <42A2B610.1020408@drzeus.cx> <42A3061C.7010604@drzeus.cx> <42B1A08B.8080601@drzeus.cx> <20050616170622.A1712@flint.arm.linux.org.uk> <42B3D830.9060100@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42B3D830.9060100@drzeus.cx>; from drzeus-list@drzeus.cx on Sat, Jun 18, 2005 at 10:15:44AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2005 at 10:15:44AM +0200, Pierre Ossman wrote:
> Russell King wrote:
> >Shouldn't there be a system device for the DMA controller?  I think
> >that should have appropriate hooks into the power management system
> >to do the necessary magic to restore whatever's needed - just like
> >we do for the PIC.
> 
> I'll have a look at how the PIC is handled then. Any corner cases I
> should be aware of?

No idea on that score I'm afraid.  Alan may know better.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
