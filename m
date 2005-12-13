Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVLMQwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVLMQwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 11:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVLMQwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 11:52:12 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:9551 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932401AbVLMQwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 11:52:11 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.6.15-rc5-mm1
Date: Tue, 13 Dec 2005 08:47:09 -0800
User-Agent: KMail/1.7.1
Cc: Alan Stern <stern@rowland.harvard.edu>,
       "J.A. Magallon" <jamagallon@able.es>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0512131032200.4831-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0512131032200.4831-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512130847.09459.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 December 2005 7:35 am, Alan Stern wrote:
> On Tue, 13 Dec 2005, J.A. Magallon wrote:

> > PCI: cache line size of 128 is not supported by device 0000:00:1d.7
> >     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> I don't think that matters.  It's more informational than a warning.

I don't even know why the PCI layer thinks we need to know about it.

Probably that came out as a side effect of noticing that the PCI
Memory-Write-Invalidate (MWI) cycle support can't be enabled; it's
an optional performance optimization, not widely supported for USB.
