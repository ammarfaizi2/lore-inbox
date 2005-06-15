Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVFOTrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVFOTrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 15:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVFOTrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 15:47:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39697 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261528AbVFOTrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 15:47:09 -0400
Date: Wed, 15 Jun 2005 20:46:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Maciej W. Rozycki" <macro@linux-mips.org>, Russ Anderson <rja@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RCF] Linux memory error handling
Message-ID: <20050615204659.A14853@flint.arm.linux.org.uk>
Mail-Followup-To: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Russ Anderson <rja@sgi.com>, linux-kernel@vger.kernel.org
References: <200506151430.j5FEUD7J1393603@clink.americas.sgi.com> <Pine.LNX.4.61L.0506151545410.13835@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61L.0506151545410.13835@blysk.ds.pg.gda.pl>; from macro@linux-mips.org on Wed, Jun 15, 2005 at 04:26:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 04:26:13PM +0100, Maciej W. Rozycki wrote:
> On Wed, 15 Jun 2005, Russ Anderson wrote:
> > 	Memory DIMM information & settings:
> > 
> > 	    Use a /proc/dimm_info interface to pass DIMM information to Linux.
> > 	    Hardware vendors could add their hardware specific settings.
> 
>  I'd recommend a more generic name rather than "dimm_info" if that is to 
> be reused universally.

Agree.

I'd also suggest that there be some method to tell the kernel from
architecture code about this "dimm_info" stuff - many embedded
platforms already know their memory organisation.

BTW, Russ, could we have a better description of what information is
intended to be supplied?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
