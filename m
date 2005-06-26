Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVFZWkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVFZWkY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 18:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVFZWjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 18:39:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19217 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261636AbVFZWhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 18:37:12 -0400
Date: Sun, 26 Jun 2005 23:37:06 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT:PATCH] 2/3: Check status of CTS when using flow control
Message-ID: <20050626233706.E28598@flint.arm.linux.org.uk>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <20050626221501.GA5769@dyn-67.arm.linux.org.uk> <20050626221750.GA5789@dyn-67.arm.linux.org.uk> <200506261826.43244.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200506261826.43244.gene.heskett@verizon.net>; from gene.heskett@verizon.net on Sun, Jun 26, 2005 at 06:26:43PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 06:26:43PM -0400, Gene Heskett wrote:
> On Sunday 26 June 2005 18:17, Russell King wrote:
> >Fix bugme #4712: read the CTS status and set hw_stopped if CTS
> >is not active.
> >
> >Thanks to Stefan Wolff for spotting this problem.
> >
> This one needs to make mainline & maybe, after 3 years, I can use a 
> pl2303 to talk to an old slow coco.  Twould be very nice if that 
> fixed the lack of flow controls the connection apparently fails from.

Sorry, wasn't aware of the problem until recently.  Reviewing the
code reveals that this bug has existed through many many many kernel
series. ;(

Have you been able to test it?  You will need the first patch as well.

(also, please remember I can't send you mail directly... still.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
