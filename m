Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbTLJPNa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 10:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbTLJPNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 10:13:30 -0500
Received: from ida.rowland.org ([192.131.102.52]:1028 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263605AbTLJPN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 10:13:26 -0500
Date: Wed, 10 Dec 2003 10:13:25 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <200312101412.57388.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0312101012020.775-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003, Duncan Sands wrote:

> > The proper fix would be to have each HC driver keep track of how many
> > instances are allocated.  The module_exit routine must wait for that
> > number to drop to 0 before returning.
> 
> Is this how it is usually done?

I don't know -- but it's how I would do it.

Maybe Greg or Randy can tell us?

Alan Stern

