Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUCPURR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 15:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUCPURR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 15:17:17 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52238 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261615AbUCPURO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 15:17:14 -0500
Date: Tue, 16 Mar 2004 20:17:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ian Campbell <icampbell@arcom.com>, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Do not include linux/irq.h from linux/netpoll.h
Message-ID: <20040316201710.A9931@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Ian Campbell <icampbell@arcom.com>, netdev@oss.sgi.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1079369568.19012.100.camel@icampbell-debian> <20040316001141.C29594@flint.arm.linux.org.uk> <20040316192247.A7886@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403161133430.17272@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0403161133430.17272@ppc970.osdl.org>; from torvalds@osdl.org on Tue, Mar 16, 2004 at 11:34:56AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 11:34:56AM -0800, Linus Torvalds wrote:
> On Tue, 16 Mar 2004, Russell King wrote:
> > > 
> > > What are your thoughts on this?
> > 
> > So how do we solve this problem.  Should I just merge this change and
> > ask you to pull it?  I think that's rather impolite though.
> 
> I didn't apply the patch because you said it was untested ;)

Ok, I've now tested the removal of linux/irq.h from netpoll.h and it
built fine for me on ARM.

However, whether there's a reason for it to be there on x86 or not
still remains to be proven.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
