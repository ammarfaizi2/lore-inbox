Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVKWS6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVKWS6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbVKWS6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:58:48 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:15722 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932178AbVKWS6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:58:47 -0500
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Fix USB suspend/resume crasher
Date: Wed, 23 Nov 2005 10:58:42 -0800
User-Agent: KMail/1.7.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alan Stern <stern@rowland.harvard.edu>
References: <1132715288.26560.262.camel@gaston> <20051123171041.GC26149@kroah.com>
In-Reply-To: <20051123171041.GC26149@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511231058.43772.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 9:10 am, Greg KH wrote:
> On Wed, Nov 23, 2005 at 02:08:07PM +1100, Benjamin Herrenschmidt wrote:
> > This patch applies on top of 

Ben, I'll look at this patch today.


> > the patch that moves the PowerMac specific 
> > code out of ohci-pci.c to hcd-pci.c where it belongs. This patch isn't
> > upstream yet for reasons I don't fully understand (why does USB stuffs
> > has such a high latency for going upstream ?), I'm sending it as a reply
> > to this email for completeness.
> 
> Sorry, I hadn't seen it, otherwise I would have sent it on.
> 
> David, are you ok with the patch Ben sent on as a followup?

It should be the same as 

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-04-usb/usb-ohci-move-ppc-asic-tweaks-nearer-pci.patch

which is already in your queue, just it's not yet upstream.
I posted it before RC1 came out, but evidently not before
your RC1-merge-to-Linus window had closed.

- Dave

