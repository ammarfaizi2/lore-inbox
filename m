Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVCIKSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVCIKSG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVCIKSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:18:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42506 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262270AbVCIKRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:17:52 -0500
Date: Wed, 9 Mar 2005 10:17:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@muc.de>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050309101728.A17289@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Andi Kleen <ak@muc.de>, Greg KH <greg@kroah.com>,
	Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050309072833.GA18878@kroah.com> <m1sm35w3am.fsf@muc.de> <1110363060.6280.74.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1110363060.6280.74.camel@laptopd505.fenrus.org>; from arjan@infradead.org on Wed, Mar 09, 2005 at 11:10:59AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 11:10:59AM +0100, Arjan van de Ven wrote:
> On Wed, 2005-03-09 at 10:56 +0100, Andi Kleen wrote:
> > One rule I'm missing:
> > 
> > - It must be accepted to mainline. 
> > 
> 
> I absolutely agree with Andi on this one.

What about the case (as highlighted in previous discussions) that the
stable tree needs a simple "dirty" fix, whereas mainline takes the
complex "clean" fix?

>From what's been said above, this means that the stable tree doesn't
get the simple "dirty" fix, because that isn't what's been accepted
into mainline.  However, it could take the complex "clean" fix, but
that may have too high an impact.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
