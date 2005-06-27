Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVF0IHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVF0IHb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 04:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVF0IHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 04:07:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10248 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261916AbVF0IFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 04:05:06 -0400
Date: Mon, 27 Jun 2005 09:05:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT:PATCH] 2/3: Check status of CTS when using flow control
Message-ID: <20050627090501.A7934@flint.arm.linux.org.uk>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <20050626221501.GA5769@dyn-67.arm.linux.org.uk> <200506261826.43244.gene.heskett@verizon.net> <20050626233706.E28598@flint.arm.linux.org.uk> <200506261938.18690.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200506261938.18690.gene.heskett@verizon.net>; from gene.heskett@verizon.net on Sun, Jun 26, 2005 at 07:38:18PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 07:38:18PM -0400, Gene Heskett wrote:
> On Sunday 26 June 2005 18:37, Russell King wrote:
> >On Sun, Jun 26, 2005 at 06:26:43PM -0400, Gene Heskett wrote:
> >> On Sunday 26 June 2005 18:17, Russell King wrote:
> >> >Fix bugme #4712: read the CTS status and set hw_stopped if CTS
> >> >is not active.
> >> >
> >> >Thanks to Stefan Wolff for spotting this problem.
> >>
> >> This one needs to make mainline & maybe, after 3 years, I can use
> >> a pl2303 to talk to an old slow coco.  Twould be very nice if that
> >> fixed the lack of flow controls the connection apparently fails
> >> from.
> >
> >Sorry, wasn't aware of the problem until recently.  Reviewing the
> >code reveals that this bug has existed through many many many kernel
> >series. ;(
> >
> Yes it has, and I may have even posted about it, but that would be a 
> year plus back into ancient history Russell.  You mention another 
> required patch also?  Where might it be obtained?

You replied to the second message in the thread (which contains the
second patch).  The first message contains the first patch.  lkml.org
has it archived if you need it.

> >(also, please remember I can't send you mail directly... still.)
> 
> I'm also getting bounces involving the address in the CC: line,
> Russell King <rmk+lkml@arm.linux.org.uk>
> 
> While I can goto vz and add that address to the incoming whitelist, I 
> doubt that would do you any good.  Looks like I need to bookmark that 
> page and start using it more often.  Did I mention how bad vz sucks?  
> Unforch, only game in this neck of the appalacians (hell I can't even 
> spell it right), sorry.
> 
> Anyway, your domain name is now in the vz whitelist.

And I now have 20 messages from verizon to postmaster / abuse requesting
that I go and fill in their "ISP" whitelist form... one to each would
have done, but 10 times as much?  That's definitely abuse in itself.

On this ISP whitelist form, Verizon require a phonenumber that they can
call anytime during some random timezone (CST, where ever that is.)
Being located in the UK, that's not acceptable so I'm unable to comply
with their requirements for whitelisting.  Sorry.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
