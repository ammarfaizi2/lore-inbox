Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265268AbTLLPqG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 10:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbTLLPqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 10:46:05 -0500
Received: from ida.rowland.org ([192.131.102.52]:6660 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265268AbTLLPqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 10:46:02 -0500
Date: Fri, 12 Dec 2003 10:46:01 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <200312112223.43056.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0312121045420.1297-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003, Duncan Sands wrote:

> By the way, my patch tests for disconnect in usbfs by doing:
> 
> if (dev->state == USB_STATE_NOTATTACHED)
> 	run_away();
> 
> Is this right?

Yes it is.

Alan Stern

