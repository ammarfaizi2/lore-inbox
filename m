Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVCLQfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVCLQfe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 11:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVCLQfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 11:35:34 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:32486 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261456AbVCLQf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 11:35:28 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino speedstep even more broken than in 2.6.10
Date: Sat, 12 Mar 2005 08:34:50 -0800
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel@vger.kernel.org,
       Felix von Leitner <felix-linuxkernel@fefe.de>
References: <3GZyA-16B-17@gated-at.bofh.it> <423278D6.2090603@shaw.ca> <20050311211908.434baba1.akpm@osdl.org>
In-Reply-To: <20050311211908.434baba1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503120834.50788.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 March 2005 9:19 pm, Andrew Morton wrote:
> 
> (Restoring email headers.  Please always use reply-to-all)
> 
> Robert Hancock <hancockr@shaw.ca> wrote:
> >
> > Felix von Leitner wrote:
> > > My new nForce 4 mainboard has 10 or so USB 2.0 outlets.  In Windows,
> > > they all work.  In Linux, two of them work.  Putting my USB stick or
> > > anything else in one of the others produces nothing in Linux.
> > > Apparently no IRQ getting through or something?
> > 
> > Likely similar to the problem I reported in this thread on 
> > linux-usb-devel - the patch that David Brownell posted fixed the problem 
> > for me..
> > 
> > http://sourceforge.net/mailarchive/message.php?msg_id=10755097
> > 

My thoughts exactly.  However, 2.6.11 includes that fix.  Are you
sure that dmesg output came from 2.6.11?

To repeat what Alan Stern said yesterday:  provide full "dmesg"
output, with CONFIG_USB_DEBUG enabled.  I think that falls into
the category of "how to provide a usable bug report" ... :)


